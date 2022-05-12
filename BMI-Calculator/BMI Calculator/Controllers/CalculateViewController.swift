//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet weak var heightValue: UILabel!
    @IBOutlet weak var weightValue: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func heightSliderChange(_ sender: UISlider) {
        heightValue.text = "\(String(format: "%.2f", sender.value))m"
    }
    
    @IBAction func weightSliderChange(_ sender: UISlider) {
        weightValue.text = "\(Int(sender.value))Kg"
    }
    
    @IBAction func onCalculate(_ sender: UIButton) {
        calculatorBrain.calculateBMIValue(height: heightSlider.value, weight: weightSlider.value)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch(segue.identifier) {
            case "goToResult":
                let destinationVC = segue.destination as! ResultViewController
                destinationVC.bmi = calculatorBrain.getBMI()
            default:
                print("HUHH?")
        }
        
    }
}

