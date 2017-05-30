//
//  HighScoresViewController.swift
//  Tappity
//
//  Created by nullUser on 30/5/17.
//  Copyright © 2017 Roan Atkinson. All rights reserved.
//

import UIKit

class HighScoresViewController: UIViewController {
    
    
    // highscore lists:
    
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
    
    
    func updateHighScoresList(_ scores: Array<Int>) {
        
        
        highScoreOne.text = "\(String(scores[0]))"
        highScoreTwo.text = "\(String(scores[1]))"
        highScoreThree.text = "\(String(scores[2]))"
        highScoreFour.text = "\(String(scores[3]))"
        highScoreFive.text = "\(String(scores[4]))"
        highScoreSix.text = "\(String(scores[5]))"
        highScoreSeven.text = "\(String(scores[6]))"
        highScoreEight.text = "\(String(scores[7]))"
        highScoreNine.text = "\(String(scores[8]))"
        highScoreTen.text = "\(String(scores[9]))"
        
        
    }

}
