//
//  VehicleDetailViewController.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/3/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit

class VehicleDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: IB Outlets
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
    
    //MARK: Member Variables
    var isMetric = true
    var isCredits = true
    var exchangeRate: Double?
    var model = [Vehicle]()
    var isStarship: Bool = true
    var client = SWAPIClient()
    let url = Searchables.vehicles.url
    var selectedVehicle: Vehicle? = nil
    
    
    
    //MARK: ViewDidLoad
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
                } else if let error = error {
                    switch error {
                    case .invalidData: print("Invalid Data, please check the url")
                    case .networkRequestFailed: AlertController.presentAlert(withVC: self, title: "Network Request Failed", message: "Please check your connection.") { [unowned self] action in
                        self.navigationController?.popToRootViewController(animated: true)
                        }
                    case .invalidKey: AlertController.presentAlert(withVC: self, title: "Invalid Key", message: "Invalid key in parser. Please contact developer if the issue persists", completionHandler: nil)
                    default: print(error)
                    }
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
                } else if let error = error {
                    switch error {
                    case .invalidData: print("Invalid Data, please check the url")
                    case .networkRequestFailed: AlertController.presentAlert(withVC: self, title: "Network Request Failed", message: "Please check your connection.") { [unowned self] action in
                        self.navigationController?.popToRootViewController(animated: true)
                        }
                    case .invalidKey: AlertController.presentAlert(withVC: self, title: "Invalid Key", message: "Invalid key in parser. Please contact developer if the issue persists", completionHandler: nil)
                    default: print(error)
                    }
                }
            }
        }
    }
    
    //MARK: PickerView Delegate/Datasource Methods
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
    
    
    //MARK: ConfigureView Method
    func configureView(model: Vehicle) {
        if isMetric {
            lengthLabel.text = "\(model.length) meters"
        } else {
            lengthLabel.text = "\(model.length.englishUnits) feet"
        }
        
        if isCredits {
            costLabel.text = "\(model.cost)"
        } else {
            guard let cost = Double(model.cost) else {
                if model.cost == "unknown" {
                    costLabel.text = model.cost
                }
                return
            }
            costLabel.text = "\(cost.dollarValue)"
        }
        vehicleNameLabel.text = model.name
        makeLabel.text = model.make
        classLabel.text = model.`class`
        crewLabel.text = model.crew
        smallestLabel.text = shortestCharacter
        largestLabel.text = tallestCharacter
    }
    
    
    //MARK: IBActions
    @IBAction func currencyExchangePressed(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func creditsPushed() {
        costLabel.text = selectedVehicle?.cost
        usdButton.setTitleColor(.gray, for: .normal)
        creditsButton.setTitleColor(.white, for: .normal)
        isCredits = true
    }
    
    @IBAction func USDPushed() {
        isCredits = false
        usdButton.setTitleColor(.white, for: .normal)
        creditsButton.setTitleColor(.gray, for: .normal)
        if ExchangeRate.dollarValue == 0.0 {
            AlertController.presentAlert(withVC: self, title: "Exchange Rate Error", message: "Please enter an exchange rate", completionHandler: nil)
            costLabel.text = "Error"
        } else {
            guard let selectedVehicle = selectedVehicle, let cost = Double(selectedVehicle.cost) else {return}
            costLabel.text = String(cost.dollarValue)
        }
    }
    
    @IBAction func metricPushed() {
        englishButton.setTitleColor(.gray, for: .normal)
        metricButton.setTitleColor(.white, for: .normal)
        isMetric = true
        guard let selectedVehicle = selectedVehicle else {return}
        lengthLabel.text = "\(selectedVehicle.length.metricUnits.description) meters"
    }
    
    @IBAction func englishPushed() {
        englishButton.setTitleColor(.white, for: .normal)
        metricButton.setTitleColor(.gray, for: .normal)
        isMetric = false
        guard let selectedVehicle = selectedVehicle else {return}
        lengthLabel.text = "\(selectedVehicle.length.englishUnits.description) feet"
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


