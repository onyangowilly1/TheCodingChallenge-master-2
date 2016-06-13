//
//  QuizUnwindSegue.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 25.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

//Going back to the mainmenue.
class QuizUnwindSegue: UIStoryboardSegue {
    
    var button: UIButton? = nil
    
    override func perform() {
        let mainVCView = destinationViewController.view as UIView!
        let quizVCView = sourceViewController.view as UIView!
        
        self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        
        self.button!.transform = CGAffineTransformScale(self.button!.transform, 15, 15)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(mainVCView, aboveSubview: quizVCView)
        
        UIView.animateWithDuration(0.6, animations: { () -> Void in
            
            self.button!.transform = CGAffineTransformMakeScale(1,1)
            
        }) { (Finished) -> Void in
            
            self.button?.enabled = false

        }
        
    }
    
    
}
