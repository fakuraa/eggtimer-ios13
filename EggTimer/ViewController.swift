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
    
    @IBOutlet weak var txtLabel: UILabel!
    let eggTimes = ["Soft":3, "Medium":4,"Hard":7]
    var counter = 0;
    var total = 0;
    var timer = Timer()

    @IBOutlet weak var progressBar: UIProgressView!
    
    var player:AVAudioPlayer?
    
    @IBAction func btnPressed(_ sender: UIButton) {
        progressBar.progress = 1
        timer.invalidate()
        total = eggTimes[sender.titleLabel?.text ?? ""] ?? 0
        counter = total
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: updateCounter(timer:))
    }
    
    func updateCounter(timer:Timer){
        if (counter > 0){
            txtLabel.text = "\(counter)"
            progressBar.setProgress((Float(counter)/Float(total)), animated: true)
            counter -= 1
        }else{
            txtLabel.text = "Done"
            progressBar.progress = 0
            self.timer.invalidate()
            playSound(soundName: "alarm_sound")
        }
    }
    
    
    func playSound(soundName : String){
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
}
