//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var activeButton: String?
    
    var calculatorBrain = CalculatorBrain()
    
    var splittedBill: Float?
    var numberOfPeople: Float?
    var tipPercentage: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tenPctButton.isSelected = true
        activeButton = tenPctButton.currentTitle        
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        activeButton = sender.currentTitle
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%0.f", sender.value)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let currentBill: Float = Float(billTextField.text!) ?? 0
        
        numberOfPeople = calculatorBrain.getNumberOfPeople(Double(splitNumberLabel.text!)!)
        tipPercentage = calculatorBrain.getPercentage(activeButton ?? "0.0")
        splittedBill = calculatorBrain.calculateBill(currentBill)

        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.splittedValue = splittedBill
            destinationVC.numberOfPeople = String(format: "%.f", numberOfPeople!)
                destinationVC.tipPercentage = String(format: "%.f", tipPercentage! * 100)
        }
    }
}


