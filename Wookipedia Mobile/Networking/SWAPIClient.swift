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
                    print(json)
                    guard let results = json["results"] as? [[String : Any]] else { completion(nil, error); return }
                    let characters = results.flatMap { Character(json: $0) }
                    completion(characters, nil)
                    
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
                    print(json)
                    let homeworld = Homeworld(json: json)
                    completion(homeworld, nil)
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
