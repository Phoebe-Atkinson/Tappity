//
//  ViewController.swift
//  Tappity
//
//  Created by RoanA on 29/5/17.
//  Copyright © 2017 Roan Atkinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // horizontal alignment conatraints for elements:
    @IBOutlet var timeLabelConatraint: NSLayoutConstraint!
    @IBOutlet var timeCounterConatraint: NSLayoutConstraint!
    @IBOutlet var scoreLabelConatraint: NSLayoutConstraint!
    @IBOutlet var scoreCounterConatraint: NSLayoutConstraint!
    
    // used for the landscape of the mainbutton's conatraints
    var mainButtonXpos: CGFloat = 0
    
    
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
    
    
    // used to store the most recent name
    var currentName: String = ""
    
    
    // struct to store highscores and names hand in hand
    struct userScore {
        var score: Int
        var name: String
    }
    
    
    // stores the top ten high scores
    var highScores = [userScore]()
    
    
    
    
    // func for handling the rotation of the screen
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        // move certain elements accordingly
        
        if (UIDevice.current.orientation.isLandscape) {
            
            mainButtonXpos = 150
            xConstraint.constant = mainButtonXpos
            timeLabelConatraint.constant = -150
            timeCounterConatraint.constant = -150
            scoreLabelConatraint.constant = -150
            scoreCounterConatraint.constant = -150
            
            
        } else {
            
            mainButtonXpos = 0
            xConstraint.constant = mainButtonXpos
            timeLabelConatraint.constant = 0
            timeCounterConatraint.constant = 0
            scoreLabelConatraint.constant = 0
            scoreCounterConatraint.constant = 0
            
        }
        
    }
    
    
    
    
    // used to initialise the IBOutlets for the HighScores view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // to initialise the highScores view
        tabBarController?.selectedIndex = 1
        tabBarController?.selectedIndex = 0
        
        
        // give highscores some blank filler values
        for _ in 1...10 {
            highScores.append(userScore(score: 0, name: ""))
        }
        
        // just used to retreive saved data
        var names = [String]()
        var scores = [Int]()
        
        // retreive any saved scores
        if let savedScores = UserDefaults.standard.array(forKey: "scores") {
            
            scores = savedScores as! [Int]
            
        }
        
        // retreive any saved names
        if let savedNames = UserDefaults.standard.array(forKey: "names") {
            
            names = savedNames as! [String]
            
        }
        
        // merge those two temp arrays into the highscores array where
        // i can use my struct
        for index in highScores {
            names.append(index.name)
            scores.append(index.score)
        }
        
        
        // fetching the class of the other viewcontroller.swift file
        let theHighScoresViewController = tabBarController?.viewControllers![1] as! HighScoresViewController
        
        // calling the updateHighScoresList
        theHighScoresViewController.updateHighScoresList(scores, names)
        
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
                self.callAlerts()
                
                // invalidate the timer
                timer.invalidate()
                
                // return so any following code will not be fun
                return
                
            }
            
        }
        
    }
    
    
    
    
    
    func callAlerts() {
        
        // highscores
        
        // I have used a method of checking if the lowest high score is smaller than the
        // current score of the user, if so setting the last value to the current score,
        // then sorting the array in descending order.
        if (presses > highScores[9].score) {
            
            highScoreAlert()
            
        } else {
            
            normalAlert()
            
        }
        
        
    }
    
    
    
    
    func setHighScores() {
        
        // order the array in descending order
        highScores = highScores.sorted { $0.score > $1.score }
        
        var names = [String]()
        var scores = [Int]()
        
        for index in highScores {
            names.append(index.name)
            scores.append(index.score)
        }
        
        // save the highScores
        UserDefaults.standard.set(scores, forKey: "scores")
        UserDefaults.standard.set(names, forKey: "names")
        
        
        // fetching the class of the other viewcontroller.swift file
        let theHighScoresViewController = tabBarController?.viewControllers![1] as! HighScoresViewController
        
        // calling the updateHighScoresList
        theHighScoresViewController.updateHighScoresList(scores, names)
        
        reset()
        
    }
    
    
    
    
    
    func normalAlert() {
        
        // create the ui alert controller
        let alertController = UIAlertController (title: "Game Over", message: "Your score is \(presses)", preferredStyle: .actionSheet)
        
        // call the alert views present method
        self.present(alertController, animated: true, completion: nil)
        
        // create an action for the ok button underneath that calls the setHighScores() func
        let okAction = UIAlertAction (title: "OK", style: .default, handler: { (alertAction) in
            self.setHighScores()
        })
        
        // add the action onto the alert view
        alertController.addAction(okAction)
        
    }
    
    
    
    
    
    func highScoreAlert() {
        
        // create the ui alert controller
        let alertController = UIAlertController(title: "Highscore", message: "Your score is \(presses)", preferredStyle: UIAlertControllerStyle.alert)
        
        // create an action for the ok button underneath that calls the setHighScores() func
        let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            self.currentName = firstTextField.text!
            self.highScores[9].score = self.presses
            self.highScores[9].name = self.currentName
            self.setHighScores()
            
        })
        
        // add a text field to the alert view
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name"
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.clearButtonMode = .whileEditing
        }
        
        // add the action onto the alert view
        alertController.addAction(saveAction)
        
        // call the alert views present method
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func reset() {
        
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
        xConstraint.constant = mainButtonXpos
        yConstraint.constant = 0
        
        // reset the most recent name
        currentName = ""
        
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

