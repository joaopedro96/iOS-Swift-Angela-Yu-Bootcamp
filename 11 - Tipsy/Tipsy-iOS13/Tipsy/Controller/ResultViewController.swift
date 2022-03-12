//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Joao Pedro da Mata Gonçalves Ribeiro on 19/06/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    var splittedValue: Float?
    var numberOfPeople: String?
    var tipPercentage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = String(splittedValue!)
        settingsLabel.text = "Splitted between \(numberOfPeople!) people, with \(tipPercentage!)% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
