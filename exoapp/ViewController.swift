//
//  ViewController.swift
//  exoapp
//
//  Created by Erwan Leboucher on 09/05/2017.
//  Copyright © 2017 Erwan Leboucher. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?

class ViewController: UIViewController {

    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    var playedtime=1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 100
        stepper.value = Double(GlobalVariables.repetition);
        valueLabel.text = String(GlobalVariables.repetition);
        timeLabel.text = String(counter)
        pauseButton.isEnabled = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var playedTimeValue: UILabel!
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        valueLabel.text = Int(sender.value).description
        GlobalVariables.repetition = Int(sender.value)
    }
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBAction func startTimer(_ sender: Any) {
        if(isPlaying) {
            return
        }
        UIApplication.shared.isIdleTimerDisabled = true
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        playedtime = 0
        playedTimeValue.text = "\(playedtime)"
        timeLabel.text = String(counter)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: GlobalVariables.sound, withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    @IBAction func settingsButton(_ sender: UIButton) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        playedtime = 0
        playedTimeValue.text = "\(playedtime)"
        timeLabel.text = String(counter)
    }
    
    func UpdateTimer() {
        if playedtime <= Int(valueLabel.text!)!*GlobalVariables.nbofleg{
            if counter <= GlobalVariables.nbofsec  {
                counter = counter + 0.1
                timeLabel.text = String(format: "%.1f", counter)
            }else{
                counter = 0
                playedTimeValue.text = "\(playedtime/GlobalVariables.nbofleg)"
                if playedtime == Int(valueLabel.text!)!*GlobalVariables.nbofleg{
                    let tmp = GlobalVariables.sound
                    GlobalVariables.sound = "complete"
                    playSound()
                    GlobalVariables.sound = tmp
                    timer.invalidate()
                    playedtime=0
                }else{
                    playSound()
                }
                playedtime+=1
                timeLabel.text = String(format: "%.1f", counter)

            }
        }
        
    }
}

