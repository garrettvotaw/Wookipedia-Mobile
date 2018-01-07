//
//  StarshipModel.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/1/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation


struct Character {
    let name: String
    let birthday: String
    let homeworld: String
    var homeworldName: String?
    let height: Double
    let eyeColor: String
    let hairColor: String
    let associateVehicles: [Vehicle]?
}

extension Character {
    init(json: [String : Any]) throws {
        guard let name = json["name"] as? String,
            let birthday = json["birth_year"] as? String,
            let homeworld = json["homeworld"] as? String,
            let height = json["height"] as? String,
            let eyeColor = json["eye_color"] as? String,
            let hairColor = json["hair_color"] as? String
            else { throw SwapiError.invalidKey }
        
        guard let heightNumber = Double(height) else { throw SwapiError.invalidData }
        
        self.name = name
        self.birthday = birthday
        self.homeworld = homeworld
        self.height = heightNumber/100
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.associateVehicles = nil
        self.homeworldName = nil
    }
}


extension Double {
    var englishUnits: Double {
        return Double(Int(((self)/0.3)*100))/100
    }
    
    var metricUnits: Double {
        return self
    }
}
