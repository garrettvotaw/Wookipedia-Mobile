//
//  HomeworldDownloader.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/12/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

class HomeworldDownloader: Operation {
    var character: Character
    
    init(character: Character) {
        self.character = character
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: character.homeworld) else { return }
        let homeworldData = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: homeworldData, options: []) as! [String: Any]
        character.homeworldName = json["name"] as? String
        if self.isCancelled {
            return
        }
    }
}
