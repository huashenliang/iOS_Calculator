//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true
    
    private var displayValue: Double {
        get{
            guard let number = Double(displayLabel.text!)  else {
                fatalError("Cannot convert display label text to a Double")
            }
            return number
        }
        
        set{
            displayLabel.text = String(newValue)
        }
    }
    
    
    //pass the display number to the CalculatorLogic class
    private var calcLogic = CalculatorLogic()
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        isFinishedTypingNumber = true
        
        //get the current display number and save to calcLogic
        calcLogic.setNumber(displayValue)
    
        if let calcMethod = sender.currentTitle {
          
            if let result = calcLogic.calculate(symbol: calcMethod) {
                  displayValue = result
            }
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        
        if let newValue = sender.currentTitle{
            
            if isFinishedTypingNumber {
                displayLabel.text = newValue
                isFinishedTypingNumber = false
            }else{
                if newValue == "." {
                    let isInt = floor(displayValue) == displayValue
                    
                    //if isInt is false, there is a decimal
                    if !isInt {
                        //stop appending the current non-value
                        return
                    }
                }
                displayLabel.text = displayLabel.text! + newValue
            }
        }
    }

}

