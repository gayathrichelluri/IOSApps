//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = K.appName
        
        /* to set the nav bar background color programatically
         if let navigationBar = navigationController?.navigationBar {
             let appearance = UINavigationBarAppearance()
             appearance.configureWithOpaqueBackground()
             appearance.backgroundColor = UIColor(named: K.BrandColors.blue)
             
             navigationBar.standardAppearance = appearance
             navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
         }
         */
        
        /* Manually adding the animation
         //Using --- "for in" ---
         titleLabel.text = ""
         let titleText = "⚡️FlashChat"
         for (index, letter) in titleText.enumerated() {
             Timer.scheduledTimer(withTimeInterval: 0.1 * Double(index), repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
         }
         
         //Using --- "forEach" ---
         titleText.enumerated().forEach { (index, value) in
             Timer.scheduledTimer(withTimeInterval: 0.1 * Double(index), repeats: false) { (timer) in
                self.titleLabel.text?.append(value)
            }
         }
         */
    }
    
}
