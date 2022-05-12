//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var timer = Timer()
    var player = AVAudioPlayer()
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func keyPressed(_ sender: UIButton) {
        //Reset
        timer.invalidate()
        secondsPassed = 0
        progressBar.progress = 0
        titleLabel.text = sender.currentTitle!
        
        totalTime = eggTimes[sender.currentTitle!]!
        
        //Counter
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
    }
    
    
    @objc func counter() {
        if(secondsPassed != totalTime) {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            ringAlarm()
        }
    }
    
    func ringAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

}
 
