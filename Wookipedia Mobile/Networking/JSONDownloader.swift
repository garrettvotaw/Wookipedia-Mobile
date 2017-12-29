//
//  JSONDownloader.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/4/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

class JsonDownloader {
    var baseUrl = URL(string: "https://swapi.co/api")

    typealias JSON = [String : Any]
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping (JSON?, SwapiError?) -> Void) -> URLSessionDataTask {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) {data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { completion(nil, .networkRequestFailed) ;return }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data) as? JSON {
                            completion(json, nil)
                        } else {
                            completion(nil, .invalidData)
                        }
                    } catch {
                        completion(nil, .invalidData)
                    }
                } else {
                    completion(nil, .networkRequestFailed)
                }
            } else {
                completion(nil, .networkRequestFailed)
            }
        }
        return task
    }
}
