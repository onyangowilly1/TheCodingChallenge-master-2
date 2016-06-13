//
//  ViewController.swift
//  CodeChallenge
//
//  Created by Jarle Matland on 31.03.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class MainVC: UIViewController, JSONSourceDelegate, JSONQuizSourceDelegate, UIViewControllerTransitioningDelegate {
    
    var tutorialStore: TutorialStore!
    var quizStore: QuizStore!
    
    var indexOfPage = 0
    var numberOfPagesNeeded: Double = 1.0
    var numberOfPagesTotal = 0
    var numberOfItemsOnLastPage = 0
    var indexOfSelectedTutorial = 0
    var indexOfSelectedQuiz = 0
    var indexOfQuizQuestion = 0
    var firstTimeLoad: Bool?
    var quizOrTutorial: String? = ""
    
    var quizScore: Int = 0
    var numberOfQuestionsFinished = 0
    var newBackgroundColor: UIColor?
    var trophyOverlayDelegate = TrophyOverlayVC()
    
    var tutorialsImage = UIImage(named: "tutorialsIcon")
    var faqImage = UIImage(named: "faqIcon")
    var quizImage = UIImage(named: "quizIcon")
    var moreTutorialsImage = UIImage(named: "tutMore")
    var mainMenuImage = UIImage(named: "mainMenu")
    var logoImage = UIImage(named: "taaLogo")
    var tutorialIcons: [UIImage] = []
    var quizIcons: [UIImage] = []
    
    @IBOutlet var logoButton: UIButton!
    @IBOutlet var codeChallengeLogo: UIImageView!
    
    // QUIZ buttons
    @IBOutlet var quizTile1: UIButton!
    @IBOutlet var quizTile2: UIButton!
    @IBOutlet var quizTile3: UIButton!
    @IBOutlet var quizTile4: UIButton!
    @IBOutlet var quizTile5: UIButton!
    @IBOutlet var quizTile6: UIButton!
    @IBOutlet var quizTile7: UIButton!
    @IBOutlet var quizTile8: UIButton!
    @IBOutlet var quizTile9: UIButton!
    @IBOutlet var quizTile10: UIButton!
    @IBOutlet var quizMainMenu: UIButton!
    @IBOutlet var scoreTile: UIButton!
    
    
    override func viewDidLoad() {
        
        setImages()
        
        buttonNo1.imageView?.image = tutorialsImage
        buttonNo2.imageView?.image = faqImage
        buttonNo3.imageView?.image = quizImage
        
        buttonNo1.hidden = false
        buttonNo2.hidden = false
        buttonNo3.hidden = false
        buttonNo4.hidden = true
        buttonNo5.hidden = false
        mainMenuButton.hidden = true
        
        buttonNo1.enabled = true
        buttonNo2.enabled = true
        buttonNo3.enabled = true
        buttonNo4.enabled = false
        buttonNo5.enabled = false
        mainMenuButton.enabled = false
        
        firstTimeLoad = true
        
        setImages()
        
        super.viewDidLoad()
    }
    
    // Animation of main menu Buttons
    @IBOutlet weak var buttonNo1: UIButton! {
        didSet {
            buttonNo1.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.6,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo1.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo2: UIButton! {
        didSet {
            buttonNo2.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.6,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo2.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo3: UIButton! {
        didSet {
            buttonNo3.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.6,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo3.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo4: UIButton! {
        didSet {
            buttonNo4.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(2.0, delay: 1, usingSpringWithDamping: 0.3,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo4.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo5: UIButton! {
        didSet {
            buttonNo5.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.5, delay: 1.5, usingSpringWithDamping: 1,initialSpringVelocity: 2, options: .CurveLinear, animations: {
                self.buttonNo5.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var mainMenuButton: UIButton! {
        didSet {
            mainMenuButton.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(2.0, delay: 1, usingSpringWithDamping: 0.5,initialSpringVelocity: 5, options: .CurveLinear, animations: {
                self.mainMenuButton.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    //Button to display The App Academy website.
    @IBAction func taaLogoButton(sender: UIButton) {
        let url = NSURL(string: "http://en.theappacademy.nl")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    // Tutorial Button + button for 1st tutorial and quiz
    @IBAction func buttonNo1Pressed(sender: UIButton) {
        if tutorialStore!.count != 0 {
            if buttonNo1.imageView?.image == tutorialsImage {
                showTutorials()
                quizOrTutorial = "tutorial"
            } else if quizOrTutorial == "tutorial" {
                findIndexOfTutorialFromImage(sender)
                performSegueWithIdentifier("showTutorial", sender: sender)
            } else if quizOrTutorial == "quiz" {
                let index = findIndexOfQuizFromImage(sender)
                numberOfQuestionsFinished = 0
                quizScore = 0
                showQuiz(index)
            }
        }
    }
    
    // APP ACADEMY FAQ BUTTON + button for 2nd tutorial and quiz
    @IBAction func button2Pressed(sender: UIButton) {
        if buttonNo2.imageView?.image == faqImage {
            performSegueWithIdentifier("showFAQ", sender: sender)
        } else if quizOrTutorial == "tutorial" {
            findIndexOfTutorialFromImage(sender)
            performSegueWithIdentifier("showTutorial", sender: sender)
        } else if quizOrTutorial == "quiz" {
            let index = findIndexOfQuizFromImage(sender)
            numberOfQuestionsFinished = 0
            quizScore = 0
            showQuiz(index)
        }
    }
    
    // QUIZ BUTTON + button for 3rd tutorial and quiz
    @IBAction func button3Pressed(sender: UIButton) {
        
        if quizStore!.count != 0 {
            if buttonNo3.imageView?.image == quizImage {
                showQuizzes()
                quizOrTutorial = "quiz"
                quizScore = 0
            } else if quizOrTutorial == "tutorial" {
                findIndexOfTutorialFromImage(sender)
                performSegueWithIdentifier("showTutorial", sender: sender)
            } else if quizOrTutorial == "quiz" {
                let index = findIndexOfQuizFromImage(sender)
                numberOfQuestionsFinished = 0
                quizScore = 0
                showQuiz(index)
            }
        }
    }
    
    // Button for 4th tutorial and quiz
    @IBAction func button4Pressed(sender: UIButton) {
        if quizOrTutorial == "tutorial" {
            findIndexOfTutorialFromImage(sender)
            performSegueWithIdentifier("showTutorial", sender: sender)
        } else if quizOrTutorial == "quiz" {
            let index = findIndexOfQuizFromImage(sender)
            numberOfQuestionsFinished = 0
            quizScore = 0
            showQuiz(index)
        }
    }
    
    @IBAction func showMoreTutorials(sender: UIButton) {
        showTutorials()
    }
    
    @IBAction func goToMainMenu(sender: UIButton) {
        if mainMenuButton.imageView?.image == mainMenuImage && quizOrTutorial == "tutorial" {
            quizOrTutorial = ""
            showMainMenu()
        } else if mainMenuButton.imageView?.image == mainMenuImage && quizOrTutorial == "quiz" {
            quizOrTutorial = ""
            showMainMenu()
        }
    }
    
    // Button to show trophy after completing a quiz
    @IBAction func quizScoreButton(sender: UIButton) {
        let overlayVC = storyboard!.instantiateViewControllerWithIdentifier("TrophyOverlayVC") as! TrophyOverlayVC
        overlayVC.updateQuizTrophyOverlay("quiz", quizName: quizStore[indexOfSelectedQuiz].name!, score: quizScore)
        prepareOverlayVC(overlayVC)
        presentViewController(overlayVC, animated: true, completion: nil)
    }
    
    // Function to prepare the trophy screen after completing quiz
    func prepareOverlayVC(overlayVC: UIViewController) {
        overlayVC.transitioningDelegate = trophyOverlayDelegate
        overlayVC.modalPresentationStyle = .FullScreen
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        
    }
    
    // Function to set up array of images from the tutorial and quiz json files
    func setImages() {
        var i = 0
        
        while tutorialStore.count == 0 {
            
        }
            // Only set up the array if the json file has been loaded, and also only do if once
            if tutorialStore.count != 0 && tutorialIcons.count == 0 {
                while i < tutorialStore!.count {
                    tutorialIcons.append(UIImage(named: tutorialStore![i].iconName!)!)
                    i += 1
                }
            }
            // Only set up the array if the json file has been loaded, and also only do if once
            if quizStore.count != 0 && quizIcons.count == 0 {
                i = 0
                while i < quizStore!.count {
                    quizIcons.append(UIImage(named: quizStore![i].iconName!)!)
                    i += 1
                }
            }
    }
    
    // Find the index number of tutorial from the selected tutorial button
    func findIndexOfTutorialFromImage(button: UIButton) -> Int {
        for image in 0..<tutorialIcons.count {
            if UIImage(named: tutorialStore[image].iconName!) == button.imageView?.image {
                indexOfSelectedTutorial = image
            }
        }
        return indexOfSelectedTutorial
    }
    
    // Find the index number of quiz from the selected tutorial button
    func findIndexOfQuizFromImage(button: UIButton) -> Int {
        for image in 0..<quizIcons.count {
            if UIImage(named: quizStore[image].iconName!) == button.imageView?.image {
                indexOfSelectedQuiz = image
            }
        }
        return indexOfSelectedQuiz
    }
    
    // Send information to the next view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTutorial" {
            
            let tutorialViewController = segue.destinationViewController as! TutorialVC
            tutorialViewController.indexOfTutorial = indexOfSelectedTutorial
            tutorialViewController.tutorialStore = self.tutorialStore
        }
        
        if segue.identifier == "showQuiz" {
            
            self.view.bringSubviewToFront(sender as! UIButton)
            sender?.setTitle("", forState: .Normal)
            let quizViewController = segue.destinationViewController as! QuizVC
            quizViewController.currentQuestion = quizStore[indexOfSelectedQuiz].questions[indexOfQuizQuestion]
            quizViewController.quizName = quizStore[indexOfSelectedQuiz].name!
            quizViewController.button = sender as? UIButton
            quizViewController.view.backgroundColor = newBackgroundColor
            
            let quizSegue = segue as! QuizSegue
            quizSegue.button = sender as? UIButton
        }
    }
    
    // Actions for Quiz Buttons
    @IBAction func quizTile1(sender: UIButton) {
        indexOfQuizQuestion = 0
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    @IBAction func quizTile2(sender: UIButton) {
        indexOfQuizQuestion = 1
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 200/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    @IBAction func quizTile3(sender: UIButton) {
        indexOfQuizQuestion = 2
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 210/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    @IBAction func quizTile4(sender: UIButton) {
        indexOfQuizQuestion = 3
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 150/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    @IBAction func quizTile5(sender: UIButton) {
        indexOfQuizQuestion = 4
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 150/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    @IBAction func quizTile6(sender: UIButton) {
        indexOfQuizQuestion = 5
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 160/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    @IBAction func quizTile7(sender: UIButton) {
        indexOfQuizQuestion = 6
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 190/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    @IBAction func quizTile8(sender: UIButton) {
        indexOfQuizQuestion = 7
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 140/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    @IBAction func quizTile9(sender: UIButton) {
        indexOfQuizQuestion = 8
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 130/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    @IBAction func quizTile10(sender: UIButton) {
        indexOfQuizQuestion = 9
        numberOfQuestionsFinished += 1
        newBackgroundColor = UIColor(red: 74/255, green: 144/255, blue: 140/255, alpha: 1)
        performSegueWithIdentifier("showQuiz", sender: sender)
    }
    
    
    
    // JSONDelegate methods
    func tutorialLoadingFailed(errorMessage: String) {
        let error = errorMessage
        print(error)
    }
    
    func tutorialDataIsLoaded() {
        setImages()
    }
    
    func quizLoadingFailed(errorMessage: String) {
        let error = errorMessage
        print(error)
    }
    
    func quizDataIsLoaded() {
        setImages()
    }
    
    
}

