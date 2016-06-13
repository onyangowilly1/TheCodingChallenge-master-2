//
//  QuizVC.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 14.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit
import AudioToolbox

class QuizVC: UIViewController {
    
    var button: UIButton?
    
    var currentQuestion: Question!
    var quizName = ""
    var userAnswer: Int = 0
    
    var score: Double = 0
    var pointsToScore: Double = 10
    var correctAnswerNeeded = false
    
    var optionImage = UIImage(named: "tutorialOption.png")
    var selectedOptionImage = UIImage(named: "tutorialOptionSelected.png")
    var wrongOptionImage = UIImage(named: "tutorialOptionWrong.png")
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var option1Button: UIButton!
    @IBOutlet var option2Button: UIButton!
    @IBOutlet var option3Button: UIButton!
    @IBOutlet var option4Button: UIButton!
    @IBOutlet var runButton: UIButton!
    @IBOutlet var quizView: UIView!
    @IBOutlet var correctLabel: UILabel!
    @IBOutlet var quizNameLabel: UILabel!
    @IBOutlet var quizHeaderView: UIView!
    
    @IBAction func exitButton(sender: UIButton) {
        self.performSegueWithIdentifier("unwindToQuiz", sender: self)
    }
    
    @IBAction func option1ButtonPressed(sender: UIButton) {
        userAnswer = 1
        option1Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
        option2Button.setBackgroundImage(optionImage, forState: .Normal)
        option3Button.setBackgroundImage(optionImage, forState: .Normal)
        option4Button.setBackgroundImage(optionImage, forState: .Normal)
    }
    
    @IBAction func option2ButtonPressed(sender: UIButton) {
        userAnswer = 2
        option1Button.setBackgroundImage(optionImage, forState: .Normal)
        option2Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
        option3Button.setBackgroundImage(optionImage, forState: .Normal)
        option4Button.setBackgroundImage(optionImage, forState: .Normal)
    }
    
    
    @IBAction func option3ButtonPressed(sender: UIButton) {
        userAnswer = 3
        option1Button.setBackgroundImage(optionImage, forState: .Normal)
        option2Button.setBackgroundImage(optionImage, forState: .Normal)
        option3Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
        option4Button.setBackgroundImage(optionImage, forState: .Normal)
    }
    
    @IBAction func option4ButtonPressed(sender: UIButton) {
        userAnswer = 4
        option1Button.setBackgroundImage(optionImage, forState: .Normal)
        option2Button.setBackgroundImage(optionImage, forState: .Normal)
        option3Button.setBackgroundImage(optionImage, forState: .Normal)
        option4Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
    }
    //sharing score on social media.
    @IBAction func share(sender: UIButton) {
        let vc = UIActivityViewController(activityItems:["\(Int(score)) / 100 points on the \(quizName) quiz with CodeChallenge app.\r\r Interested in coding? Check out @AppAcademyNL"], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //RunButton to display answers options.
    @IBAction func runButton(sender: AnyObject) {
        
        if userAnswer == currentQuestion.correctOption && correctAnswerNeeded == false {
            score = ceil(pointsToScore)
            option1Button.hidden = true
            option2Button.hidden = true
            option3Button.hidden = true
            option4Button.hidden = true
            correctLabel.hidden = false
            quizHeaderView.hidden = true
            questionLabel.text = currentQuestion?.correctAnswerText
            runButton.setTitle("Next question", forState: .Normal)
            correctAnswerNeeded = true
        
        } else if userAnswer == currentQuestion.correctOption && correctAnswerNeeded == true {
            self.performSegueWithIdentifier("unwindToQuiz", sender: self)
            correctAnswerNeeded = false
        }
        else if userAnswer != currentQuestion.correctOption {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            pointsToScore = pointsToScore - 3
            
            if pointsToScore <= 0 {
                pointsToScore = 0
            }
            
            if userAnswer == 1 {
                option1Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                option2Button.setBackgroundImage(optionImage, forState: .Normal)
                option3Button.setBackgroundImage(optionImage, forState: .Normal)
                option4Button.setBackgroundImage(optionImage, forState: .Normal)
                
                option1Button.setTitle("Wrong answer. Try again!", forState: .Normal)
                option2Button.setTitle(currentQuestion.option2! as String, forState: .Normal)
                option3Button.setTitle(currentQuestion.option3! as String, forState: .Normal)
                option4Button.setTitle(currentQuestion.option4! as String, forState: .Normal)
            }
            if userAnswer == 2 {
                option1Button.setBackgroundImage(optionImage, forState: .Normal)
                option2Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                option3Button.setBackgroundImage(optionImage, forState: .Normal)
                option4Button.setBackgroundImage(optionImage, forState: .Normal)
                
                option1Button.setTitle(currentQuestion.option1! as String, forState: .Normal)
                option2Button.setTitle("Wrong answer. Try again!", forState: .Normal)
                option3Button.setTitle(currentQuestion.option3! as String, forState: .Normal)
                option4Button.setTitle(currentQuestion.option4! as String, forState: .Normal)
            }
            if userAnswer == 3 {
                option1Button.setBackgroundImage(optionImage, forState: .Normal)
                option2Button.setBackgroundImage(optionImage, forState: .Normal)
                option3Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                option4Button.setBackgroundImage(optionImage, forState: .Normal)
                
                option1Button.setTitle(currentQuestion.option1! as String, forState: .Normal)
                option2Button.setTitle(currentQuestion.option2! as String, forState: .Normal)
                option3Button.setTitle("Wrong answer. Try again!", forState: .Normal)
                option4Button.setTitle(currentQuestion.option4! as String, forState: .Normal)
            }
            if userAnswer == 4 {
                option1Button.setBackgroundImage(optionImage, forState: .Normal)
                option2Button.setBackgroundImage(optionImage, forState: .Normal)
                option3Button.setBackgroundImage(optionImage, forState: .Normal)
                option4Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                
                option1Button.setTitle(currentQuestion.option1! as String, forState: .Normal)
                option2Button.setTitle(currentQuestion.option2! as String, forState: .Normal)
                option3Button.setTitle(currentQuestion.option3! as String, forState: .Normal)
                option4Button.setTitle("Wrong answer. Try again!", forState: .Normal)
            }
        }
    }
    
    override func viewDidLoad() {

        questionLabel.text = currentQuestion!.question
        option1Button.setTitle(currentQuestion!.option1! as String, forState: .Normal)
        option2Button.setTitle(currentQuestion!.option2! as String, forState: .Normal)
        option3Button.setTitle(currentQuestion!.option3! as String, forState: .Normal)
        option4Button.setTitle(currentQuestion!.option4! as String, forState: .Normal)
        
        option1Button.hidden = false
        option2Button.hidden = false
        option3Button.hidden = false
        option4Button.hidden = false

        correctLabel.hidden = true
        quizHeaderView.hidden = false
        quizNameLabel.text = quizName
        
        runButton.setTitle("Answer", forState: .Normal)
        
        correctAnswerNeeded = false

    }
    //Going back to the MainVC.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToQuiz" {

            let mainViewController = segue.destinationViewController as! MainVC
            
            mainViewController.quizScore = mainViewController.quizScore + Int(score)
            mainViewController.scoreTile.setTitle("\(mainViewController.quizScore) / 100\r points", forState: .Disabled)
            
            if mainViewController.numberOfQuestionsFinished == 10 {
                mainViewController.scoreTile.setBackgroundImage(UIImage(named: "finishedQuizTile.png"), forState: .Normal)
                mainViewController.scoreTile.setTitle("Press me!!", forState: .Normal)
                mainViewController.scoreTile.enabled = true
            }
            
            let quizUnwindSegue = segue as! QuizUnwindSegue
            quizUnwindSegue.button = button
            
            
        }
    }
    
}
