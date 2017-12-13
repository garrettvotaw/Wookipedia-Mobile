//
//  ViewController.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/1/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let client = SWAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func characterTapped() {
        
    }
    
    @IBAction func vehicleTapped() {}
    
    @IBAction func starshipTapped() {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VehicleSegue" {
            if let nextView = segue.destination as? VehicleDetailViewController {
                nextView.isStarship = false
            }
        } else {
            if let nextView = segue.destination as? VehicleDetailViewController {
                nextView.isStarship = true
            }
        }
    }
    
}

