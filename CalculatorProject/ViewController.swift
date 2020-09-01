//
//  ViewController.swift
//  CalculatorProject
//
//  Created by The App Experts on 27/08/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    var defaultLabelText = "0.0"
     //? how to get that tags to don't need to change it on two places if that will be neccessary ?
    let comaSignTag = 17, clearTag = 10, equalsTag = 18, plusTag = 16, minusTag = 15, multiplyTag = 14, divideTag = 13, percentTag = 12, signChangeTag = 11
    let comaSign = ".", plusSign = "+", minusSign = "-", multiplySign = "*", divisionSign = "/", percentSign = "%", equalSign = "="
    
    
    var displayedNumber: Float = 0
    var numberBeforeLast: Float = 0
    var lastNumber: Float = 0
    var calculating: Bool = false
    var operationSymbol:Int = 0
    
    /*getting and displaying numbers in the label
     numbers are get by tag assigned to them
    checkup is necessary for default text clears the default text first time round
    */
    @IBAction func getAndDisplayNumber(_ sender: UIButton) {
        if displayLabel.text == defaultLabelText {
            displayLabel.text = ""
        }
        if calculating {
            displayLabel.text = String(sender.tag)
            displayedNumber = Float(displayLabel.text!)!
            calculating = false
        } else {
            var symbol = ""
            if sender.tag == comaSignTag {
               if displayLabel.text!.isEmpty {
                    symbol = "0."
                } else if  (displayLabel.text?.contains(String(comaSign)))!{
                    symbol=""
                } else if !(displayLabel.text?.contains(String(comaSign)))!{
                    symbol = "."
               }
            } else {
                symbol = String(sender.tag)
            }
                
            displayLabel.text = displayLabel.text! + symbol
            displayedNumber = Float(displayLabel.text!)!
        }
    }
    
    /*
     func to do calculation or clear screen
     */
    @IBAction func calculateOrClear(_ sender: UIButton) {
        var tag = sender.tag
 
        if !displayLabel.text!.isEmpty && tag != clearTag && tag != equalsTag && tag != signChangeTag{
//            numberBeforeLast = lastNumber
            lastNumber = Float(displayLabel.text!)!
            switch tag {
            case plusTag:
                displayLabel.text = plusSign
            case minusTag:
                displayLabel.text = minusSign
            case multiplyTag:
                displayLabel.text = multiplySign
            case divideTag:
                displayLabel.text = divisionSign
            case percentTag:
                displayLabel.text = percentSign
            default:
                return
            }
            operationSymbol = tag
            calculating = true
        }
        
        if tag == equalsTag {
            switch operationSymbol {
            case plusTag:
                displayLabel.text = String(lastNumber+displayedNumber)
            case minusTag:
                displayLabel.text = String(lastNumber-displayedNumber)
            case multiplyTag:
                displayLabel.text = String(lastNumber*displayedNumber)
            case divideTag:
                displayLabel.text = String(lastNumber/displayedNumber)
            case percentTag:
                displayLabel.text = String(lastNumber * (displayedNumber / 100))+percentSign
            default:
                return
            }
        }
        
//        if tag == percentTag {
//            displayLabel.text = String(numberBeforeLast * (lastNumber / 100))+percentSign
//            print("percentage \(numberBeforeLast) * \(lastNumber/100) \(lastNumber) \(operationSymbol)")
//        }
        
        if tag == clearTag {
            displayLabel.text = defaultLabelText
            lastNumber = 0.0
            displayedNumber = 0.0
            operationSymbol = 0
        }

        if tag == signChangeTag && displayLabel.text! != defaultLabelText{
            if !displayLabel.text!.contains(minusSign) {
                displayLabel.text = minusSign + displayLabel.text!
            } else {
                displayLabel.text = displayLabel.text!.replacingOccurrences(of: minusSign, with: "")

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("starting....")

        displayLabel.text = defaultLabelText
    }


}

