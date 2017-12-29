//
//  AlertController.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/18/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit
import Foundation

class AlertController{
    static func presentAlert(withVC viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
