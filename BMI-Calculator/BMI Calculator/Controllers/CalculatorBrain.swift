//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Gayathri Chelluri on 13/4/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    var bmi: BMI?
    let colors = (
        underWeight: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
        normalWeight: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
        overWeight: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    )
    
    func getBMI() -> BMI? {
        return bmi
    }
    
    mutating func calculateBMIValue(height: Float, weight: Float) {
        let bmiValue = weight / (height*height)
        
        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "Eat more pies!", color: colors.underWeight)
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: colors.normalWeight)
        } else {
            bmi = BMI(value: bmiValue, advice: "Eat less pies!", color: colors.overWeight)
        }
    }
    
}
