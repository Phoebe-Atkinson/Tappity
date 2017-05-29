//
//  ViewController.swift
//  Tappity
//
//  Created by nullUser on 29/5/17.
//  Copyright © 2017 Roan Atkinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // the Time display label
    @IBOutlet var timeLabel: UILabel!
    
    // the Score display label
    @IBOutlet var scoreLabel: UILabel!
    
    
    // isPlaying boolean var to store whether the user is in a game or not
    var isPlaying: Bool = false
    var presses: Int = 0
    

    // mainButtonPushed func hooked up to the button
    @IBAction func mainButtonPushed(_ sender: UIButton) {
        
        // run seperate code to execute the game
        if (!isPlaying) {
            
            // call the startGame func
            startGame()
            
            // return so any following code will not be fun
            return
            
        }
        
        
        //    if isPlaying
        // vv              vv
        //
        
        // increment the presses var once
        presses += 1
        
        
    }
    
    
    
    func startGame() {
        
        // set isPlaying to true
        isPlaying = true
        
        // increment presses on first go because i'm nice
        presses += 1
        
        // var for timer to use
        var secondsLeft: Int = 30
        
        // begin the game and start the timer
        let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            
            // update the secondsLeft var
            secondsLeft -= 1
            
            // update the timeLabel
            self.timeLabel.text = "\(secondsLeft)"
            
            if (secondsLeft == 0) {
                
                // call end game func
                self.endGame()
                
                // return so any following code will not be fun
                return
                
            }
            
        }
        
    }
    
    
    func endGame() {
        
        // set isPlaying to false
        isPlaying = false
        
    }


}

