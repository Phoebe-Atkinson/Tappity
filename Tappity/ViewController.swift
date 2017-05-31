//
//  ViewController.swift
//  Tappity
//
//  Created by nullUser on 29/5/17.
//  Copyright © 2017 Roan Atkinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // main button contraints
    @IBOutlet var yConstraint: NSLayoutConstraint!
    @IBOutlet var xConstraint: NSLayoutConstraint!
    
    // the game view
    @IBOutlet var gameView: UIView!
    
    // the Time display label
    @IBOutlet weak var timeLabel: UILabel!
    
    // the Score display label
    @IBOutlet weak var scoreLabel: UILabel!
    
    // the main button
    @IBOutlet weak var mainButton: UIButton!
    
    
    // isPlaying boolean var to store whether the user is in a game or not
    var isPlaying: Bool = false
    
    // presses var to store how many times the user presses the button
    // coincedentally is the score of the user
    var presses: Int = 0
    
    // stores the 10 possible colours to add difficulty
    var colours: Array = [UIColor.gray, UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.lightGray, UIColor.red, UIColor.green, UIColor.orange, UIColor.purple, UIColor.yellow]
    
    // stores the top ten high scores
    var highScores: Array<Int> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    
    
    // used to initialise the IBOutlets for the HighScores view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tabBarController?.selectedIndex = 1
        tabBarController?.selectedIndex = 0
        

        
        // retreive any saved values
        if let savedValue = UserDefaults.standard.array(forKey: "highscores") {
            
            highScores = savedValue as! Array<Int>
            
            // fetching the class of the other viewcontroller.swift file
            let theHighScoresViewController = tabBarController?.viewControllers![1] as! HighScoresViewController
            
            // calling the updateHighScoresList
            theHighScoresViewController.updateHighScoresList(highScores)
            
            
        }
        
    }
    
    
    // mainButtonPushed func hooked up to the button
    @IBAction func mainButtonPushed(_ sender: UIButton) {
        
        // run seperate code to execute the game
        if (!isPlaying) {
            
            // call the startGame func
            startGame()
            
        }
        
        
        // increment the presses var once
        presses += 1
        
        // update the scoreLabel
        scoreLabel.text = "\(presses)"
        
        // generate random number
        let random = Int(arc4random_uniform(10))
        
        // set background colours of game view to random colours
        gameView.backgroundColor = colours[random]
        
        // move button randomly
        moveButton()
        
        
    }
    
    
    
    func startGame() {
        
        // set isPlaying to true
        isPlaying = true
        
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
                
                // invalidate the timer
                timer.invalidate()
                
                // return so any following code will not be fun
                return
                
            }
            
        }
        
    }
    
    
    func endGame() {
        
        // create the ui alert controller
        let alertController = UIAlertController (title: "Game Over", message: "Your score is \(presses)", preferredStyle: .actionSheet)
        
        // call the alert views present method
        self.present(alertController, animated: true, completion: nil)
        
        // create an action for the ok button underneath that calls the reset() func
        let okAction = UIAlertAction (title: "OK", style: .default, handler: { (alertAction) in
            self.reset()
        })
        
        // add the action onto the alert view
        alertController.addAction(okAction)
        
    }
    
    
    func reset() {
        
        // highscores
        
        // I have used a method of checking if the lowest high score is smaller than the
        // current score of the user, if so setting the last value to the current score,
        // then sorting the array in descending order.
        if (presses > highScores[9]) {
            
            highScores[9] = presses
            
        }
        
        // order the array in descending order
        highScores = highScores.sorted { $0 > $1 }
        
        // save the highScores
        UserDefaults.standard.set(highScores, forKey: "highscores")
        
        // fetching the class of the other viewcontroller.swift file
        let theHighScoresViewController = tabBarController?.viewControllers![1] as! HighScoresViewController
        
        // calling the updateHighScoresList
        theHighScoresViewController.updateHighScoresList(highScores)
        
        // set isPlaying to false
        isPlaying = false
        
        // reset the presses var
        presses = 0
        
        // update the scoreLabel
        scoreLabel.text = "\(presses)"
        
        // update the timeLabel
        timeLabel.text = "30"
        
        // reset main view colours
        gameView.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        
        // reset main button constraints:
        xConstraint.constant = 0
        yConstraint.constant = 0
        
    }
    
    
    
    func moveButton() {
        
        // move button randomly:
        
        
        
        // X Axis:
        
        
        // generate random num between 0 and max X pos for button
        let xRandNum = (view.frame.width / 2) - (mainButton.frame.width / 2)
        var xRand = Int(arc4random_uniform(UInt32(xRandNum + 1)))
        
        // random chance of num being negative or positive
        let xDir = arc4random_uniform(2)
        if (xDir == 0) {
            xRand = xRand * (-1)
        }
        
        
        
        // Y Axis:
        
        
        // generate random num between 0 and max Y pos for button
        let yRandNum = (view.frame.height / 2) - (mainButton.frame.height / 2)
        var yRand = Int(arc4random_uniform(UInt32(yRandNum + 1)))
        
        // random chance of num being negative or positive
        let yDir = arc4random_uniform(2)
        if (yDir == 0) {
            yRand = yRand * (-1)
        }
        
        
        
        // set the constraint constants
        xConstraint.constant = CGFloat(xRand)
        yConstraint.constant = CGFloat(yRand)
        
    }
    
    


}

