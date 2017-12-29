//
//  DetailViewController.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/1/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let client = SWAPIClient()
    var model = [Character]()
    var selectedCharacter: Character!
    var isMetric = true
    
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
        selectedCharacter = model[row]
    }
    
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var metricButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var homePlanetLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    @IBOutlet weak var characterPicker: UIPickerView!
    @IBOutlet weak var smallesCharacterLabel: UILabel!
    @IBOutlet weak var largestCharacterLabel: UILabel!

    let character: Character? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterPicker.delegate = self
        characterPicker.dataSource = self
        let search = Searchables.people
        client.getCharacters(url: search.url) { [unowned self] characters, error in
            if let characters = characters {
                self.model = characters.sorted { $0.name < $1.name }
                self.characterPicker.reloadAllComponents()
                self.configureView(model: self.model[0])
                self.selectedCharacter = self.model[0]
            } else if let error = error {
                switch error {
                case .invalidData: print("Invalid Data, please check the url")
                case .networkRequestFailed: AlertController.presentAlert(withVC: self, title: "Network Request Failed", message: "Please check your connection.")
                case .invalidKey: print("Invalid Key, please check your parser")
                default: print(error)
                }
            }
        }
    }
    
    @IBAction func englishPressed() {
        englishButton.setTitleColor(.white, for: .normal)
        metricButton.setTitleColor(.gray, for: .normal)
        heightLabel.text = "\(selectedCharacter.height.englishUnits) feet"
        isMetric = false
    }
    
    @IBAction func metricPressed() {
        englishButton.setTitleColor(.gray, for: .normal)
        metricButton.setTitleColor(.white, for: .normal)
        heightLabel.text = "\(selectedCharacter.height.metricUnits) meters"
        isMetric = true
    }
    
    func configureView(model: Character) {
        if isMetric {
            heightLabel.text = "\(model.height) meters"
        } else {
            heightLabel.text = "\(model.height.englishUnits) feet"
        }
        nameLabel.text = model.name
        birthdayLabel.text = model.birthday
        eyeColorLabel.text = model.eyeColor
        hairColorLabel.text = model.hairColor
        client.getHomeWorld(character: model) { [unowned self] home, error in
            if let home = home {
                self.homePlanetLabel.text = home.name
            }
        }
        smallesCharacterLabel.text = shortestCharacter
        largestCharacterLabel.text = tallestCharacter
    }
    
    var shortestCharacter: String {
        let newModel = model.sorted {$0.height < $1.height}
        return newModel[0].name
    }
    
    var tallestCharacter: String {
        let newModel = model.sorted {$0.height > $1.height}
        return newModel[0].name
    }
    
}
