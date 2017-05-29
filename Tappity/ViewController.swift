//
//  ViewController.swift
//  Tappity
//
//  Created by nullUser on 29/5/17.
//  Copyright © 2017 Roan Atkinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    
    var isPlaying: Bool = false
    var presses: Int = 0
    

    @IBAction func mainButtonPushed(_ sender: UIButton) {
        
        
        if (!isPlaying) {
            
            
            startGame()
            return
            
        }
        
        
        //    if isPlaying
        // vv              vv
        //
        
        // increment the presses var once
        
        
    }
    
    func startGame() {
        
        isPlaying = true
        
        // begin the game and start the timer
        
        presses += 1
        
    }


}

