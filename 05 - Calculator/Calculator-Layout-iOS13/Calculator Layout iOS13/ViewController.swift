//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
extension String {
    func numberOfOccurrencesOf(string: String) -> Int { //contador de caracteres repetidos na string. Copiei do stack overflow XD
        return self.components(separatedBy:string).count - 1
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorOutputLabel: UILabel! //label de exibicao
    
    var dataStored: Double = 0 //numero armazenado antes de definir um operador
    var displayedText: String = "" //numero armazenado que esta exibido na tela
    
    let operatorArray: Array = ["=", "+", "-", "×", "÷"] //vetor que define os operadores
    var currentOperatorIndex: Int = 0 //index para identificar os comandos no vetor
    
    
    @IBAction func buttonDataInput(_ sender: UIButton) {
        if displayedText.numberOfOccurrencesOf(string: ".") != 1 || sender.currentTitle != "."{
            displayedText += sender.currentTitle! //monta a string
            calculatorOutputLabel.text = displayedText //exibe a string na label
        }
    }
    
    @IBAction func buttonAllClear(_ sender: UIButton) { //reseta pro estado inicial
        dataStored = 0
        currentOperatorIndex = 0
        calculatorOutputLabel.text = "0"
        displayedText = ""
    }
    
    @IBAction func buttonSetOperator(_ sender: UIButton) {
        if displayedText != "." { //nao permite q nenhuma operacao seja feita se label == .
            currentOperatorIndex = operatorArray.firstIndex(of: sender.currentTitle!)! //set index
            if !displayedText.isEmpty { //se label tiver vazia, nao faz nada
                dataStored = Double(displayedText)!
                displayedText = ""
            }
        }
    }
    
    @IBAction func buttonSymmetricValue(_ sender: UIButton) {
        if dataStored == 0 { //se nenhum dado tiver sido armazenado, armazena o valor da tela
            displayedText = calculatorOutputLabel.text! //atualiza a variavel de "" para "0"
            dataStored = Double(displayedText)!
        }
        dataStored = dataStored * (-1)
        displayedText = String(dataStored)
        calculatorOutputLabel.text = displayedText
    }
    
    @IBAction func buttonPercentValue(_ sender: UIButton) {
        //TODO
    }
    
    @IBAction func buttonSolve(_ sender: UIButton) {
        if !displayedText.isEmpty { //se displayedText == "", nao faz nada
            switch currentOperatorIndex { //seleciona a operacao de acordo com o index
            case 0:
                dataStored = Double(displayedText)!
            case 1:
                dataStored += Double(displayedText)!
            case 2:
                dataStored -= Double(displayedText)!
            case 3:
                dataStored *= Double(displayedText)!
            case 4:
                dataStored /= Double(displayedText)!
            default:
                dataStored = 9999999999 //deixei esse valor pra testar erro
            }
            calculatorOutputLabel.text = String(dataStored)
            displayedText = ""
            currentOperatorIndex = 0
        }
    }
}

