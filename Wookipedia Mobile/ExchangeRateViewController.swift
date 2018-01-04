//
//  ExchangeRateViewController.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 1/3/18.
//  Copyright © 2018 Garrett Votaw. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    @IBOutlet weak var dollarsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitPressed() {
        do {
            try submitExchangeRate()
            self.navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
    func submitExchangeRate() throws {
        guard let dollarString = dollarsTextField.text else {throw SwapiError.emptyExchangeRate}
        guard let dollarValue = Double(dollarString) else {throw SwapiError.invalidEntry}
        if dollarValue <= 0 {
            AlertController.presentAlert(withVC: self, title: "Invalid Entry", message: "Please enter a non-negative and non-zero number", completionHandler: nil)
            throw SwapiError.invalidEntry
        } else {
            ExchangeRate.dollarValue = dollarValue
        }
    }
}
