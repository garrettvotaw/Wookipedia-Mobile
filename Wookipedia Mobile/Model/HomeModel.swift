//
//  HomeModel.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/12/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

struct Homeworld {
    let name: String
}

extension Homeworld {
    init(json: [String:Any]) {
        self.name = json["name"] as! String
    }
}
