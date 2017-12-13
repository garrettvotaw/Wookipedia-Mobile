//
//  VehicleDetailViewController.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/3/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit

class VehicleDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    
    var isStarship: Bool = true
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var vehiclePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(isStarship)
    }

}
