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
        guard var unwrapedDisplayLabelText = displayLabel.text else { return }

        if unwrapedDisplayLabelText == defaultLabelText {
            unwrapedDisplayLabelText = ""
        }
        
        if calculating {
            unwrapedDisplayLabelText = String(sender.tag)
            displayedNumber = Float(unwrapedDisplayLabelText)!
            calculating = false
        } else {
            var symbol = ""
            if sender.tag == comaSignTag {
               if unwrapedDisplayLabelText.isEmpty {
                    symbol = "0."
               } else if  (unwrapedDisplayLabelText.contains(String(comaSign))){
                    symbol=""
               } else if !(unwrapedDisplayLabelText.contains(String(comaSign))){
                    symbol = "."
               }
            } else {
                symbol = String(sender.tag)
            }
                
            unwrapedDisplayLabelText = unwrapedDisplayLabelText + symbol
            displayedNumber = Float(unwrapedDisplayLabelText)!
        }
        displayLabel.text = unwrapedDisplayLabelText
    }
    
    /*
     func to do calculation or clear screen
     */
    @IBAction func calculateOrClear(_ sender: UIButton) {
        let tag = sender.tag

        guard var unwrapedDisplayLabelText = displayLabel.text else { return }
 
        if !unwrapedDisplayLabelText.isEmpty && tag != clearTag && tag != equalsTag && tag != signChangeTag{
//            numberBeforeLast = lastNumber
            lastNumber = Float(unwrapedDisplayLabelText)!
            switch tag {
            case plusTag:
                unwrapedDisplayLabelText = plusSign
            case minusTag:
                unwrapedDisplayLabelText = minusSign
            case multiplyTag:
                unwrapedDisplayLabelText = multiplySign
            case divideTag:
                unwrapedDisplayLabelText = divisionSign
            case percentTag:
                unwrapedDisplayLabelText = percentSign
            default:
                return
            }
            operationSymbol = tag
            calculating = true
        }
        
        if tag == equalsTag {
            switch operationSymbol {
            case plusTag:
                unwrapedDisplayLabelText = String(lastNumber+displayedNumber)
            case minusTag:
                unwrapedDisplayLabelText = String(lastNumber-displayedNumber)
            case multiplyTag:
                unwrapedDisplayLabelText = String(lastNumber*displayedNumber)
            case divideTag:
                unwrapedDisplayLabelText = String(lastNumber/displayedNumber)
            case percentTag:
                unwrapedDisplayLabelText = String(lastNumber * (displayedNumber / 100))+percentSign
            default:
                return
            }
        }
        
//        if tag == percentTag {
//            displayLabel.text = String(numberBeforeLast * (lastNumber / 100))+percentSign
//            print("percentage \(numberBeforeLast) * \(lastNumber/100) \(lastNumber) \(operationSymbol)")
//        }
        
        if tag == clearTag {
            unwrapedDisplayLabelText = defaultLabelText
            lastNumber = 0.0
            displayedNumber = 0.0
            operationSymbol = 0
        }

        if tag == signChangeTag && unwrapedDisplayLabelText != defaultLabelText{
            if !unwrapedDisplayLabelText.contains(minusSign) {
                unwrapedDisplayLabelText = minusSign + unwrapedDisplayLabelText
            } else {
                unwrapedDisplayLabelText = unwrapedDisplayLabelText.replacingOccurrences(of: minusSign, with: "")

            }
        }
        
        displayLabel.text = unwrapedDisplayLabelText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("starting....")

        displayLabel.text = defaultLabelText
    }


}

