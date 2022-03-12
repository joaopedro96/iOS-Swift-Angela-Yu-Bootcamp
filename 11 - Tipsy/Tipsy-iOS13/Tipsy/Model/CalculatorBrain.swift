//
//  CalculatorBrain.swift
//  Tipsy
//
//  Created by Joao Pedro da Mata Gonçalves Ribeiro on 19/06/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    var numberOfPeople: Float?
    var tipPercentage: Float?
    
    mutating func getNumberOfPeople(_ splitterValue: Double) -> Float{
        numberOfPeople = Float(splitterValue)
        return numberOfPeople!
    }
    
    mutating func getPercentage(_ activeButton: String) -> Float{
        var stringPercentage: String = activeButton
        stringPercentage.removeLast()
        tipPercentage = Float(stringPercentage)! / 100
        return tipPercentage!
    }
    
    mutating func calculateBill (_ actualBill: Float) -> Float {
        let splittedBill = (actualBill * (1 + tipPercentage!)) / numberOfPeople!
        return splittedBill
    }
}
