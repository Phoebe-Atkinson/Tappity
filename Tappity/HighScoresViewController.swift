//
//  HighScoresViewController.swift
//  Tappity
//
//  Created by nullUser on 30/5/17.
//  Copyright © 2017 Roan Atkinson. All rights reserved.
//

import UIKit

class HighScoresViewController: UIViewController {
    
    // highscore label IBOutlets:
    
    @IBOutlet weak var highScoreOne: UILabel!
    @IBOutlet weak var highScoreTwo: UILabel!
    @IBOutlet weak var highScoreThree: UILabel!
    @IBOutlet weak var highScoreFour: UILabel!
    @IBOutlet weak var highScoreFive: UILabel!
    @IBOutlet weak var highScoreSix: UILabel!
    @IBOutlet weak var highScoreSeven: UILabel!
    @IBOutlet weak var highScoreEight: UILabel!
    @IBOutlet weak var highScoreNine: UILabel!
    @IBOutlet weak var highScoreTen: UILabel!
    
    
    // to update the labels to their appropriate high scores
    func updateHighScoresList(_ scores: Array<Int>, _ names: Array<String>) {
        
        highScoreOne.text = "\(names[0]) \(String(scores[0]))"
        highScoreTwo.text = "\(names[1]) \(String(scores[1]))"
        highScoreThree.text = "\(names[2]) \(String(scores[2]))"
        highScoreFour.text = "\(names[3]) \(String(scores[3]))"
        highScoreFive.text = "\(names[4]) \(String(scores[4]))"
        highScoreSix.text = "\(names[5]) \(String(scores[5]))"
        highScoreSeven.text = "\(names[6]) \(String(scores[6]))"
        highScoreEight.text = "\(names[7]) \(String(scores[7]))"
        highScoreNine.text = "\(names[8]) \(String(scores[8]))"
        highScoreTen.text = "\(names[9]) \(String(scores[9]))"
        
    }

}
