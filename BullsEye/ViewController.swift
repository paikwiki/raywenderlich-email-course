//
//  ViewController.swift
//  BullsEye
//
//  Created by Changhyun Paik on 2020/04/12.
//  Copyright © 2020 paikwiki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    // TODO: Make "Start Over" button works
    
    func startNewRound() {
        if round < 5 {
            round += 1
        } else {
            round = 0
            score = 0
        }
        
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
    }
    
    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        if points == 100 {
            points *= 2
        } else if points > 98 {
            points += 50
        }
        score += points
        
        let title: String
        let message: String
        if round == 5 {
            title = "Game over"
        } else if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        if round == 5 {
            message = "Your score: \(score) points."
        } else {
            message = "You scored \(points) points."
        }
        
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
                                    
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: { _ in
                                                self.startNewRound()
                                            })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }

}

