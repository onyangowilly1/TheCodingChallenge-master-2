//
//  throphyVC.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 19.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class TrophyOverlayVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var throphy: UIImageView!
    @IBOutlet var congratulationsLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var mainMenuButton: UIButton!
    
    var tutorialName: String = ""
    var score: Int = 0
    var quizName: String = ""
    var toBeDisplayed: String = ""
    
    // Functons to share results from Tutorials and Quiz on social media
    @IBAction func share(sender: UIButton) {
        var textToShare: String = ""
        
        if toBeDisplayed == "quiz" {
            textToShare = "\(Int(score)) / 100 pts. on \(quizName) quiz with CodeChallenge app.\r\r Interested in coding? Check out en.theappacademy.nl"
        } else if toBeDisplayed == "tutorial" {
            textToShare = "I just completed a Swift tutorial with CodeChallenge app\r\r Interested in coding? Check out en.theappacademy.nl"
        }
        
        let vc = UIActivityViewController(activityItems:[textToShare], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    // Empty now, but will contain link to more tutorials/videos online
    @IBAction func learnMore(sender: UIButton) {
    }
    
    // Unwind to Main Menu
    @IBAction func goToMainMenu(sender: UIButton) {
        self.performSegueWithIdentifier("unwindToMenu", sender: self)
    }
    
    // Sets up the trophy screen on loading
    override func viewDidLoad() {
        
        if toBeDisplayed == "quiz" {
            textLabel.text = "You've completed the \(quizName) quiz and scored \(Int(score)) / 100 points!"
        } else if toBeDisplayed == "tutorial" {
            textLabel.text = "You've completed the \(tutorialName) tutorial! \r\r"
        }
        
        for _ in 0..<80 {
            drawRandomCircles(25)
        }
        
        // Brings all lables ++ infront of the screen, on top of the circles
        self.view.bringSubviewToFront(logo)
        self.view.bringSubviewToFront(throphy)
        self.view.bringSubviewToFront(shareButton)
        self.view.bringSubviewToFront(mainMenuButton)
        self.view.bringSubviewToFront(congratulationsLabel)
        self.view.bringSubviewToFront(textLabel)
    }
    
    // Update the trophy screen with Quiz info
    func updateQuizTrophyOverlay(toBeDisplayed: String, quizName: String, score: Int) {
        self.toBeDisplayed = toBeDisplayed
        self.quizName = quizName
        self.score = score
    }
    
    // Update the trophy screen with Tutorial info
    func updateTutorialTrophyOverlay(toBeDiplayed: String, tutorialName: String) {
        self.toBeDisplayed = toBeDiplayed
        self.tutorialName = tutorialName
    }
    
    // Function to draw random colored circles on the screen
    func drawRandomCircles(radiusDivider: CGFloat) {
        
        let circleLayer = CAShapeLayer()
        
        //Find random x and y values
        let randomX = CGFloat(arc4random_uniform(UInt32(self.view.bounds.size.width)))
        let randomY = CGFloat(arc4random_uniform(UInt32(self.view.bounds.size.height)))
        
        let randomCenter = CGPointMake(randomX, randomY)
        
        // Make random radius
        let randomRadius = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.height/radiusDivider)))
        
        let circlePath = UIBezierPath(arcCenter: randomCenter, radius: randomRadius, startAngle: 1, endAngle: 100, clockwise: true)
        
        let randomColor = getRandomColor()
        let randomRed = randomColor.red
        let randomGreen = randomColor.green
        let randomBlue = randomColor.blue
        
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.5).CGColor
        circleLayer.strokeColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.5).CGColor
        circleLayer.lineWidth = 0.2
        
        view.layer.addSublayer(circleLayer)
    }
    
    // Get random color for the circles
    func getRandomColor() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return (randomRed, randomBlue, randomGreen)
    }
}
