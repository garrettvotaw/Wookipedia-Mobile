//
//  SWAPIError.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/14/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import Foundation

enum SwapiError: Error {
    case invalidData
    case networkRequestFailed
    case urlFailed
}
