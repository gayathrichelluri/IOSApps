//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Gayathri Chelluri on 13/4/2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var bmi: BMI?

    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var suggestionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bmi?.color ?? .systemGray
        bmiLabel.text = String(format: "%.1f", bmi?.value ?? 0.0)
        suggestionLabel.text = bmi?.advice ?? "No result yet!"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onRecalculate(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
