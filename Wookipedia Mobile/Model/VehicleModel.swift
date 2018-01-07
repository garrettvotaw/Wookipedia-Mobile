//
//  VehicleModel.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/1/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

struct Vehicle {
    let name: String
    let make: String
    let cost: String
    let length: Double
    let `class`: String
    let crew: String
    let isStarship: Bool
}

extension Vehicle {
    init(jsonVehicle: [String : Any]) throws {
        guard let name = jsonVehicle["name"] as? String,
        let make = jsonVehicle["model"] as? String,
        let cost = jsonVehicle["cost_in_credits"] as? String,
        let length = jsonVehicle["length"] as? String,
        let `class` = jsonVehicle["vehicle_class"] as? String,
        let crew = jsonVehicle["crew"] as? String else {throw SwapiError.invalidKey}
        
        self.name =  name
        self.make = make
        self.cost = cost
        self.length = Double(length)!
        self.`class` = `class`
        self.crew = crew
        self.isStarship = false
    }
    
    init(jsonStarship: [String : Any]) throws {
        guard let name = jsonStarship["name"] as? String,
            let make = jsonStarship["model"] as? String,
            let cost = jsonStarship["cost_in_credits"] as? String,
            let length = jsonStarship["length"] as? String,
            let `class` = jsonStarship["starship_class"] as? String,
            let crew = jsonStarship["crew"] as? String else {throw SwapiError.invalidKey}
        
        self.name =  name
        self.make = make
        self.cost = cost
        self.length = Double(length)!
        self.`class` = `class`
        self.crew = crew
        self.isStarship = true
    }
}
