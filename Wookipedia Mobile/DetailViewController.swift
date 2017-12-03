//
//  DetailViewController.swift
//  Wookipedia Mobile
//
//  Created by Garrett Votaw on 12/1/17.
//  Copyright © 2017 Garrett Votaw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Chewy"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterPicker.delegate = self
        characterPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func englishPressed() {
        englishButton.setTitleColor(.white, for: .normal)
        metricButton.setTitleColor(.gray, for: .normal)
    }
    
    @IBAction func metricPressed() {
        englishButton.setTitleColor(.gray, for: .normal)
        metricButton.setTitleColor(.white, for: .normal)
    }
    
    func configureView(model: Character) {
        nameLabel.text = model.name
        birthdayLabel.text = model.birthday
        homePlanetLabel.text = model.homeworld
        heightLabel.text = String(model.height)
        eyeColorLabel.text = model.eyeColor
        hairColorLabel.text = model.hairColor
    }
}


















