//
//  ViewController.swift
//  TipCalculator
//
//  Created by Mikael Joseph Kaufman on 11/14/20.
//

import UIKit

class ViewController: UIViewController {
    
    let tipPercentages = [0.0, 0.15, 0.20, 0.25]

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
        
        // Sets the title in the Navigation Bar
        self.title = "Tip Calculator"
        
        // Set light or Dark Mode from User data
        if UserDefaults.standard.bool(forKey: "myDark") {
            darkSwitch.setOn(true, animated: true)
            
            if !(darkSwitch.isOn) {
                overrideUserInterfaceStyle = .light
                UserDefaults.standard.set(false, forKey: "myDark")
            }
            else{
                overrideUserInterfaceStyle = .dark
                UserDefaults.standard.set(true, forKey: "myDark")
            }
            
        }
        
        //Load User Data
        billField.text = String(format: "%.2f", UserDefaults.standard.double(forKey: "myBill"))
        peopleLabel.text = UserDefaults.standard.string(forKey: "myParty")
        peopleSlider.value = Float(UserDefaults.standard.integer(forKey: "mySlider"))
        tipLabel.text = String(format: "$%.2f", UserDefaults.standard.double(forKey: "myTip"))
        totalLabel.text = String(format: "$%.2f", UserDefaults.standard.double(forKey: "myTotal"))
        tipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "myTipPercentage")
        self.billField.becomeFirstResponder()
        
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func darkMode(_ sender: Any) {
        
        if !(darkSwitch.isOn) {
            overrideUserInterfaceStyle = .light
            UserDefaults.standard.set(false, forKey: "myDark")
        }
        else{
            overrideUserInterfaceStyle = .dark
            UserDefaults.standard.set(true, forKey: "myDark")
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
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
                
        let total = bill + (tip/Double(peopleSlider.value))
        
        //update the tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        //Save User Data
        
        UserDefaults.standard.set(tip, forKey: "myTip")
        UserDefaults.standard.set(bill, forKey: "myBill")
        UserDefaults.standard.set(total, forKey: "myTotal")
        UserDefaults.standard.set(peopleSlider.value, forKey: "mySlider")
        UserDefaults.standard.set(peopleLabel.text, forKey: "myParty")
        UserDefaults.standard.set(tipControl.selectedSegmentIndex, forKey: "myTipPercentage")
        
    }
}


