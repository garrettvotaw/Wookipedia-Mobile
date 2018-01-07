//
//  SWAPIClient.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/6/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

class SWAPIClient {
    let downloader = JsonDownloader()
    typealias JSON = [String : Any]
    
    func getCharacters(url: URL, completionHandler completion: @escaping ([Character]?, SwapiError?) -> Void) {
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) {json, error in
            DispatchQueue.main.async {
                if let json = json {
                    guard let results = json["results"] as? [[String : Any]] else { completion(nil, .invalidKey); return }
                    var characters = [Character]()
                    for character in results {
                        do {
                            characters.append(try Character(json: character))
                        } catch {
                            completion(nil, .invalidKey)
                        }
                    }
                    if !characters.isEmpty {
                        completion(characters, nil)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func getHomeWorld(character: Character, completionHandler completion: @escaping (Homeworld?, SwapiError?) -> Void) {
        guard let url = URL(string: character.homeworld) else { completion(nil, SwapiError.urlFailed); return }
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) {json, error in
            DispatchQueue.main.async {
                if let json = json {
                    do {
                        let homeworld = try Homeworld(json: json)
                        completion(homeworld, nil)
                    } catch {
                        completion(nil, .invalidKey)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func getVehicles(searchable: Searchables, completionHandler completion: @escaping ([Vehicle]?, SwapiError?) -> Void) {
        var url: URL!
        if searchable == .vehicles {
            url = searchable.url
        } else if searchable == .starships {
            url = searchable.url
        }
        
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) {json, error in
            DispatchQueue.main.async {
                if let json = json {
                    guard let results = json["results"] as? [[String: Any]] else  {completion(nil, .invalidKey); return}
                    if searchable == .vehicles {
                        var vehicles = [Vehicle]()
                        for vehicle in results {
                            do {
                                vehicles.append(try Vehicle(jsonVehicle: vehicle))
                            } catch {
                                completion(nil, .invalidKey)
                            }
                        }
                        if !vehicles.isEmpty {
                            completion(vehicles, nil)
                        }
                    } else {
                        var starships = [Vehicle]()
                        for starship in results {
                            do {
                                starships.append(try Vehicle(jsonStarship: starship))
                            } catch {
                                completion(nil, .invalidKey)
                            }
                        }
                        if !starships.isEmpty {
                            completion(starships, nil)
                        }
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
