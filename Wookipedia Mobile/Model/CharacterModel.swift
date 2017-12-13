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
    let homeworld: String?
    let height: String
    let eyeColor: String
    let hairColor: String
    let associateVehicles: [Vehicle]?
}

extension Character {
    init? (json: [String : Any]) {
        self.name = json["name"] as! String
        self.birthday = json["birth_year"] as! String
        self.homeworld = nil
        self.height = json["height"] as! String
        self.eyeColor = json["eye_color"] as! String
        self.hairColor = json["hair_color"] as! String
        self.associateVehicles = nil
    }
}
