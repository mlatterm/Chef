//
//  AddPantryViewController.swift
//  PocketChef
//
//  Created by Max Lattermann on 10/26/20.
//  Copyright © 2020 Max Lattermann. All rights reserved.
//

import UIKit

class AddPantryViewController: UIViewController {
    
    @IBOutlet weak var picker: UIPickerView!

    let data = ["gallons", "liters", "pints", "quarts", "fluid ounces", "pounds", "ounzes", "kilograms", "grams", "cups", "tablespoons", "teaspoons"]

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
    }

}

extension AddPantryViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
}

extension AddPantryViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}
