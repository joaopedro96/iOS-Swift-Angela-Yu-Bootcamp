//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //    }
    
    @IBAction func keyPressed(_ sender: UIButton) {
        collorFade(button: sender)
        playSound(noteName: (sender.titleLabel?.text)!)
    }
    
    func playSound(noteName: String) {
        let url = Bundle.main.url(forResource: noteName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func collorFade(button: UIButton){
        button.alpha = 0.5
//      delayEvent(timeElapsed: 0.2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            button.alpha = 1
        }
    }
    
    //    func delayEvent (timeElapsed: Double) {
    //        DispatchQueue.main.asyncAfter(deadline: .now() + timeElapsed){
    //        }
    //    }
}



