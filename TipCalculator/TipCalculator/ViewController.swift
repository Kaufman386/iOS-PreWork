//
//  ViewController.swift
//  TipCalculator
//
//  Created by Mikael Joseph Kaufman on 11/14/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UITextField!
    @IBOutlet weak var totalLabel: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var darkSwitch: UISwitch!
    @IBOutlet weak var peopleSlider: UISlider!
    @IBOutlet weak var peopleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func darkMode(_ sender: Any) {
        
        if !(darkSwitch.isOn) {
            overrideUserInterfaceStyle = .light
        }
        else{
            overrideUserInterfaceStyle = .dark
        }
        
    }
    
    @IBAction func calculatePeople(_ sender: Any) {
        
        peopleSlider.value = round(peopleSlider.value)
        
        peopleLabel.text = "Amount of People: " + String(Int(peopleSlider.value))
        
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        //Get the bill amount
        let bill = Double(billField.text!) ?? 0
        
        //Calculate the tip and total
        let tipPercentages = [0.0, 0.15, 0.20, 0.25]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        
        let total = bill + (tip/Double(peopleSlider.value))
        
        //update the tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }
}

