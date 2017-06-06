//
//  InterfaceController.swift
//  Watch Tappity Extension
//
//  Created by nullUser on 2/6/17.
//  Copyright © 2017 Roan Atkinson. All rights reserved.
//

import WatchKit
import Foundation
import UIKit


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    
    
    // the score label
    @IBOutlet var scoreLabel: WKInterfaceLabel!
    
    // the time label
    @IBOutlet var timerLabel: WKInterfaceLabel!
    
    
    // isPlaying boolean var to store whether the user is in a game or not
    var isPlaying: Bool = false
    
    // presses var to store how many times the user presses the button
    // coincedentally is the score of the user
    var presses: Int = 0
    
    
    
    // mainButtonPushed func hooked up to the button
    @IBAction func mainButtonPressed() {
        
        if (!isPlaying) {
            
            // set isPlaying to true
            isPlaying = true
            
            // var for timer to use
            var secondsLeft: Int = 30
            
            // begin the game and start the timer
            let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
                
                // update the secondsLeft var
                secondsLeft -= 1
                
                // update the timeLabel
                self.timerLabel.setText("\(secondsLeft)")
                
                if (secondsLeft == 0) {
                    
                    // call end game func
                    self.endGame()
                    
                    // invalidate the timer
                    timer.invalidate()
                    
                    // return so any following code will not be fun
                    return
                    
                }
                
            }
            
        }
        
        // increment the presses var once
        presses += 1
        
        // update the scoreLabel
        scoreLabel.setText("\(presses)")
        
    }
    
    
    func endGame() {
    
        let action = WKAlertAction(title: "Dismiss", style: WKAlertActionStyle.default) { () -> Void in }
        
        _ = self.presentAlert(withTitle: "Game over", message: "Your score is \(presses)", preferredStyle: WKAlertControllerStyle.actionSheet, actions: [action])
        
        // set isPlaying to false
        isPlaying = false
        
        // reset the presses var
        presses = 0
        
        // update the scoreLabel
        scoreLabel.setText("\(presses)")
        
        // update the timeLabel
        timerLabel.setText("30")
        
    }
    
    

}
