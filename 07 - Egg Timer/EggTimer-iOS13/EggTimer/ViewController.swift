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
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var elapsedTime: Int = 0
    var timer = Timer()
    var totalTime: Int = 0
    
    @IBOutlet weak var displayedLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer?
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        elapsedTime = 0
        progressBar.progress = 0
        displayedLabel.text = sender.currentTitle
        elapsedTime = eggTimes[sender.currentTitle!]!
        totalTime = elapsedTime
        startCountdown()
    }
    
    func startCountdown(){
       timer =  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if elapsedTime > 0 {
            elapsedTime -= 1
            progressBar.progress = 1 - Float(elapsedTime)/Float(totalTime)
        } else {
            timer.invalidate()
            displayedLabel.text = "Done"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }
}

