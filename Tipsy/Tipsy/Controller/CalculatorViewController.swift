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
    
    var selectedTipButton: UIButton!
    var splittedTotal: String = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedTipButton = tenPctButton
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        selectedTipButton.isSelected = false
        sender.isSelected = true
        selectedTipButton = sender
        
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let tipPct = Float(selectedTipButton.currentTitle!.dropLast())!/100.0
        
        if let billText = billTextField.text, !billText.isEmpty {
            let billEntered = Float(billTextField.text!)!
            let billWithTip: Float = billEntered + (billEntered * tipPct)
            
            splittedTotal = String(format: "%.2f", billWithTip/Float(splitNumberLabel.text!)!)
            print(splittedTotal)
        }
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier) {
        case "goToResult":
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.splittedTotal = splittedTotal
            destinationVC.tipPct = selectedTipButton.currentTitle!
            destinationVC.totalPeople = splitNumberLabel.text!
        default:
            print("HUHH?")
        }
    }
    
}

