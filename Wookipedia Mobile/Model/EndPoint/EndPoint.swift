//
//  EndPoint.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/4/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    var base: String {
        return "http://swapi.co/api/"
    }
}


enum Searchables: String {
    case people
    case starships
    case vehicles
}

extension Searchables: Endpoint {
    var path: String {
        switch self {
        case .people: return "people/"
        case .starships: return "starships/"
        case .vehicles: return "vehicles/"
        }
    }
    
    var url: URL {
        let urlString = base + path
        return URL(string: urlString)!
    }
}


