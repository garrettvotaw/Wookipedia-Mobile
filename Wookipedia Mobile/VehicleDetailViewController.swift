//
//  VehicleDetailViewController.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/3/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit

class VehicleDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        configureView(model: model[row])
        selectedVehicle = model[row]
    }
    
    var exchangeRate: Double?
    var model = [Vehicle]()
    var isStarship: Bool = true
    var client = SWAPIClient()
    let url = Searchables.vehicles.url
    var selectedVehicle: Vehicle? = nil
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var crewLabel: UILabel!
    @IBOutlet weak var vehiclePicker: UIPickerView!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var creditsButton: UIButton!
    @IBOutlet weak var metricButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    var isMetric = true
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vehiclePicker.delegate = self
        vehiclePicker.dataSource = self
        if isStarship == false {
            self.navigationItem.title = "Vehicle"
            client.getVehicles(searchable: Searchables.vehicles) { [unowned self] vehicles, error in
                if let vehicles = vehicles {
                    self.model = vehicles
                    self.vehiclePicker.reloadAllComponents()
                    self.configureView(model: vehicles[0])
                    self.selectedVehicle = vehicles[0]
                }
            }
        } else if isStarship == true {
            self.navigationItem.title = "Starship"
            client.getVehicles(searchable: Searchables.starships) { [unowned self] starships, error in
                if let starships = starships {
                    self.model = starships
                    self.vehiclePicker.reloadAllComponents()
                    self.configureView(model: starships[0])
                    self.selectedVehicle = starships[0]
                }
            }
        }
    }
    
    
    func configureView(model: Vehicle) {
        if isMetric {
            lengthLabel.text = "\(model.length) meters"
        } else {
            lengthLabel.text = "\(model.length.englishUnits) feet"
        }
        vehicleNameLabel.text = model.name
        makeLabel.text = model.make
        costLabel.text = model.cost
        classLabel.text = model.`class`
        crewLabel.text = model.crew
        smallestLabel.text = shortestCharacter
        largestLabel.text = tallestCharacter
        
    }
    
    
    @IBAction func creditsPushed() {
        usdButton.setTitleColor(.gray, for: .normal)
        creditsButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func USDPushed() {
//        let alert = UIAlertController(title: "Exchange Rate", message: "Please enter the number of dollars 1 Credit is worth", preferredStyle: .alert)
//
//        alert.addTextField {textfield in
//            textfield.keyboardType = UIKeyboardType.decimalPad
//            self.exchangeRate = Double(textfield.text!)
//        }
//        let action = UIAlertAction(title: "OK", style: .default) {alert in
//            self.costLabel.text = String(describing: self.exchangeRate)
//        }
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
        usdButton.setTitleColor(.white, for: .normal)
        creditsButton.setTitleColor(.gray, for: .normal)
    }
    
    @IBAction func metricPushed() {
        englishButton.setTitleColor(.gray, for: .normal)
        metricButton.setTitleColor(.white, for: .normal)
        isMetric = true
        lengthLabel.text = "\(selectedVehicle!.length.metricUnits.description) meters"
    }
    
    @IBAction func englishPushed() {
        englishButton.setTitleColor(.white, for: .normal)
        metricButton.setTitleColor(.gray, for: .normal)
        isMetric = false
        lengthLabel.text = "\(selectedVehicle!.length.englishUnits.description) feet"
    }
    
    var shortestCharacter: String {
        let newModel = model.sorted {$0.length < $1.length}
        return newModel[0].name
    }
    
    var tallestCharacter: String {
        let newModel = model.sorted {$0.length > $1.length}
        return newModel[0].name
    }
    

}
