//
//  OverlayTransitionDelegate.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 13.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class TutorialOverlayVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var pictureTextLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nextButton: UIButton!
    
    var answerText: String?
    var currentChallenge: Int?
    var totalChallenges: Int?
    var name: String?
    var endText: String?
    var finishedChallenge: Bool = false
    var tutorialStore: TutorialStore!
    var trophyOverlayDelegate = TrophyOverlayVC()
    
    var displayImage = ""
    var imageToDisplay: String = ""
    var image: UIImage?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }
    
    // Sets up the overlay depending on what need to be showed
    override func viewDidLoad() {
        if displayImage == "noImageToDisplay" {
            textLabel.text = answerText
            pictureTextLabel.hidden = true
            imageView.hidden = true
        } else if displayImage == "fromOptions" {
            textLabel.hidden = true
            pictureTextLabel.hidden = false
            pictureTextLabel.text = answerText
            imageView.image = UIImage(named: imageToDisplay)
            imageView.hidden = false
        } else if displayImage == "fromTakenPhoto" {
            textLabel.hidden = true
            pictureTextLabel.hidden = false
            pictureTextLabel.text = answerText
            imageView.image = image
            imageView.hidden = false
        }
    }

    // Go to next challenge OR go to trophy screen if this was the last challenge
    @IBAction func nextChallenge(sender: UIButton) {
        
        if currentChallenge != totalChallenges {
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else if currentChallenge == totalChallenges && finishedChallenge == false {
            
            textLabel.text = endText
            textLabel.hidden = false
            imageView.hidden = true
            pictureTextLabel.hidden = true
            
            nextButton.setTitle("Finish Tutorial", forState: .Normal)
            finishedChallenge = true
            
        } else if finishedChallenge == true {
            let overlayVC = storyboard!.instantiateViewControllerWithIdentifier("TrophyOverlayVC") as! TrophyOverlayVC
            
            prepareOverlayVC(overlayVC)
            
            overlayVC.updateTutorialTrophyOverlay("tutorial", tutorialName: name!)
            
            presentViewController(overlayVC, animated: true, completion: nil)

            finishedChallenge = false
        }
    }
    
    // Function to update the overlay depending on what needs to be displayed
    func updateOverlay(name: String, correctAnswer: String, currentChallenge: Int, totalChallenges: Int, endText: String, displayImage: String, imageName: String, image: UIImage?) {
        
        if displayImage == "noImageToDisplay" {
            self.name = name
            self.answerText = correctAnswer
            self.currentChallenge = currentChallenge
            self.totalChallenges = totalChallenges
            self.endText = endText
            self.displayImage = "noImageToDisplay"

        } else if displayImage == "fromOptions" {
            self.name = name
            self.answerText = correctAnswer
            self.currentChallenge = currentChallenge
            self.totalChallenges = totalChallenges
            self.endText = endText
            self.imageToDisplay = imageName
            self.displayImage = "fromOptions"
            self.image = image
        } else if displayImage == "fromTakenPhoto" {
            self.name = name
            self.answerText = correctAnswer
            self.currentChallenge = currentChallenge
            self.totalChallenges = totalChallenges
            self.endText = endText
            self.imageToDisplay = ""
            self.displayImage = "fromTakenPhoto"
            self.image = image
        }
        
        
    }
    
    private func prepareOverlayVC(overlayVC: UIViewController) {
        overlayVC.transitioningDelegate = trophyOverlayDelegate
        overlayVC.modalPresentationStyle = .FullScreen
    }
    
    // UIViewControllerTransitioningDelegate methods
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        if presented == self {
            return OverlayPresentationController(presentedViewController: presented, presentingViewController: presenting)
        }
        
        return nil
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if presented == self {
            return OverlayAnimationController(isPresenting: true)
        }
        else {
            return nil
        }
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if dismissed == self {
            return OverlayAnimationController(isPresenting: false)
        }
        else {
            return nil
        }
    }
    
}