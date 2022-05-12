//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Gayathri Chelluri on 19/4/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var splittedTotal: String = "0.0"
    var tipPct: String = "0%"
    var totalPeople: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = String(splittedTotal)
        settingsLabel.text = "Split between \(totalPeople) people, with \(tipPct) tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
