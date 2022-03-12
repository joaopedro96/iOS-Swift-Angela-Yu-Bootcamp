//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}
//MARK: - PickerViewDelegate & DataSource
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    //set the number of collums for the picker view (from UIPickerViewDataSource)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //set  the number of rows for the picker view (from UIPickerViewDataSource)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    //set the current title for each row (from UIPickerViewDelegate)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    //set the row (as an int) selected by the user (from UIPickerViewDelegate)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        currencyLabel.text = selectedCurrency
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func lastBtcPrice(bitcoinData: CryptoModel){
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", bitcoinData.currencyRate)
        }
    }
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
