//
//  QuizSegue.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 25.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

// Custom animated segue for quiz tiles
class QuizSegue: UIStoryboardSegue {
    
    var button: UIButton?
    
    override func perform() {
        let firstVCView = self.sourceViewController.view as UIView!
        let secondVCView = self.destinationViewController.view as UIView!
        
        let quizViewController = destinationViewController as! QuizVC
        
        // Get the screen width and height.
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        secondVCView.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight)
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        quizViewController.quizView.transform = CGAffineTransformScale(quizViewController.quizView.transform, 0.001, 0.001)
        secondVCView.transform = CGAffineTransformScale(secondVCView.transform, 0.001, 0.001)
        
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            self.button!.transform = CGAffineTransformMakeScale(15,15)
            quizViewController.quizView.transform = CGAffineTransformIdentity
            
        }) { (Finished) -> Void in
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                secondVCView.transform = CGAffineTransformIdentity
                
                }, completion: { (Finished) -> Void in
                    
                    firstVCView.transform = CGAffineTransformIdentity
                    self.sourceViewController.presentViewController(self.destinationViewController as UIViewController, animated: false, completion: nil)
            })
        }
        
        
    }
    
}