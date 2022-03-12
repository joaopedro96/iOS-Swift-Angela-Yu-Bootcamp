//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Joao Pedro da Mata Gonçalves Ribeiro on 18/06/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    var bmi: BMI?

    mutating func calculateBMI (_ height: Float,_ weight: Float) {
        let bmiValue: Float = weight / (height * height)
        var bmiColor: UIColor?
        var bmiAdvice: String?
        
        
        if bmiValue < 18.5 && bmiValue > 0{
            bmiColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            bmiAdvice = "Get heavier dude!!!"
        } else if bmiValue > 24.9 {
            bmiColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            bmiAdvice = "Get lighter dude!!!"
        } else {
            bmiColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            bmiAdvice = "AWESOME"
        }
        bmi = BMI(value: bmiValue, color: bmiColor ?? .black, advice: bmiAdvice ?? "ok")
    }

    func getBMIValue() -> Float {
        return bmi?.value ?? 0.0
    }
    
    func getBMIColor() -> UIColor {
        return bmi?.color ?? .black
    }
    
    func getBMIAdvice() -> String {
        return bmi?.advice ?? "ok"
    }
}

