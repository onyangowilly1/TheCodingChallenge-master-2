//
//  MainExtensionTutorials.swift
//  CodingChallenge
//
//  Created by Jarle Matland on 08.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

extension MainVC {
    
    // SGo back to main menu from tutorial or quiz
    func showMainMenu() {
        
        buttonNo1.setImage(tutorialsImage, forState: .Normal)
        buttonNo2.setImage(faqImage, forState: .Normal)
        buttonNo3.setImage(quizImage, forState: .Normal)
        buttonNo5.setImage(logoImage, forState: .Normal)
        
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
        
        quizTile1.enabled = false
        quizTile2.enabled = false
        quizTile3.enabled = false
        quizTile4.enabled = false
        quizTile5.enabled = false
        quizTile6.enabled = false
        quizTile7.enabled = false
        quizTile8.enabled = false
        quizTile9.enabled = false
        quizTile10.enabled = false
        quizMainMenu.enabled = false
        scoreTile.enabled = false
        
        quizTile1.hidden = true
        quizTile2.hidden = true
        quizTile3.hidden = true
        quizTile4.hidden = true
        quizTile5.hidden = true
        quizTile6.hidden = true
        quizTile7.hidden = true
        quizTile8.hidden = true
        quizTile9.hidden = true
        quizTile10.hidden = true
        quizMainMenu.hidden = true
        scoreTile.hidden = true
        
        logoButton.hidden = false
        logoButton.enabled = true
        codeChallengeLogo.hidden = false
        
    }
    
    // Show the Tutorials menu
    func showTutorials() {
        
        buttonNo5.setImage(moreTutorialsImage, forState: .Normal)
        mainMenuButton.setImage(mainMenuImage, forState: .Normal)
        
        buttonNo4.enabled = true
        buttonNo5.enabled = true
        mainMenuButton.enabled = true
        mainMenuButton.hidden = false
        
        indexOfPage = 0
        
        // Calculate the number of pages needed and number of tutorials on the last page
        if tutorialStore.count <= 4 {
            numberOfPagesNeeded = 1
            numberOfPagesTotal = 1
            numberOfItemsOnLastPage = tutorialStore.count
            buttonNo5.setImage(logoImage, forState: .Normal)
            buttonNo5.enabled = false
        } else {
            numberOfPagesNeeded = Double(tutorialStore.count) / 4.0
            numberOfPagesTotal = Int(ceil(numberOfPagesNeeded))
            numberOfItemsOnLastPage = 4 - Int((numberOfPagesTotal * 4) - tutorialStore.count)
        }
        
        // If already on the last page of tutorials, then go to the first page
        if indexOfPage == numberOfPagesTotal - 1 {
            indexOfPage = 0
        } else {
            indexOfPage += 1
        }
        
        if indexOfPage <= numberOfPagesTotal - 1 {
            
            let startIndexOfPicForPage = indexOfPage * 4
            
            // Only display the number of tutorials that is needed on the last page
            if numberOfItemsOnLastPage == 1 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = true
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
                
                self.buttonNo1.enabled = true
                self.buttonNo2.enabled = false
                self.buttonNo3.enabled = false
                self.buttonNo4.enabled = false
            }
            
            if numberOfItemsOnLastPage == 2 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(tutorialIcons[startIndexOfPicForPage+1], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
                
                self.buttonNo1.enabled = true
                self.buttonNo2.enabled = true
                self.buttonNo3.enabled = false
                self.buttonNo4.enabled = false
            }
            
            if numberOfItemsOnLastPage == 3 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(tutorialIcons[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(tutorialIcons[startIndexOfPicForPage+2], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = true
                
                self.buttonNo1.enabled = true
                self.buttonNo2.enabled = true
                self.buttonNo3.enabled = true
                self.buttonNo4.enabled = false
            }
            
            if numberOfItemsOnLastPage == 4 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(tutorialIcons[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(tutorialIcons[startIndexOfPicForPage+2], forState: .Normal)
                buttonNo4.setImage(tutorialIcons[startIndexOfPicForPage+3], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = false
                
                self.buttonNo1.enabled = true
                self.buttonNo2.enabled = true
                self.buttonNo3.enabled = true
                self.buttonNo4.enabled = true
            }
        }
    }
    
    // Show the Quiz menu
    func showQuizzes() {
        
        buttonNo5.setImage(moreTutorialsImage, forState: .Normal)
        mainMenuButton.setImage(mainMenuImage, forState: .Normal)
        
        buttonNo4.enabled = true
        buttonNo5.enabled = true
        mainMenuButton.enabled = true
        mainMenuButton.hidden = false
        scoreTile.enabled = false
        
        
        indexOfPage = 0
        
        // Calculate the number of pages needed and number of quizzes on the last page
        if quizStore.count <= 4 {
            numberOfPagesNeeded = 1
            numberOfPagesTotal = 1
            numberOfItemsOnLastPage = quizStore.count
            buttonNo5.setImage(logoImage, forState: .Normal)
            buttonNo5.enabled = false
        } else {
            numberOfPagesNeeded = Double(quizStore.count) / 4.0
            numberOfPagesTotal = Int(ceil(numberOfPagesNeeded))
            numberOfItemsOnLastPage = 4 - Int((numberOfPagesTotal * 4) - quizStore.count)
        }
        
        // If already on the last page of tutorials, then go to the first page
        if indexOfPage == numberOfPagesTotal - 1 {
            indexOfPage = 0
        } else {
            indexOfPage += 1
        }
        
        if indexOfPage <= numberOfPagesTotal - 1 {
            
            let startIndexOfPicForPage = indexOfPage * 4
            
            // Only display the number of quizzes that is needed on the last page
            if numberOfItemsOnLastPage == 1 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = true
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
                
                self.buttonNo1.enabled = true
                self.buttonNo2.enabled = false
                self.buttonNo3.enabled = false
                self.buttonNo4.enabled = false
            }
            
            if numberOfItemsOnLastPage == 2 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(quizIcons[startIndexOfPicForPage+1], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
                
                self.buttonNo1.enabled = true
                self.buttonNo2.enabled = true
                self.buttonNo3.enabled = false
                self.buttonNo4.enabled = false
            }
            
            if numberOfItemsOnLastPage == 3 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(quizIcons[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(quizIcons[startIndexOfPicForPage+2], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = true
                
                self.buttonNo1.enabled = true
                self.buttonNo2.enabled = true
                self.buttonNo3.enabled = true
                self.buttonNo4.enabled = false
            }
            
            if numberOfItemsOnLastPage == 4 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(quizIcons[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(quizIcons[startIndexOfPicForPage+2], forState: .Normal)
                buttonNo4.setImage(quizIcons[startIndexOfPicForPage+3], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = false
                
                self.buttonNo1.enabled = true
                self.buttonNo2.enabled = true
                self.buttonNo3.enabled = true
                self.buttonNo4.enabled = true
            }
        }
    }
    
    // Show the Quiz tiles/questions of a selected Quiz
    func showQuiz(quizIndex: Int) {
        
        buttonNo1.enabled = false
        buttonNo2.enabled = false
        buttonNo3.enabled = false
        buttonNo4.enabled = false
        buttonNo5.enabled = false
        mainMenuButton.enabled = false
        
        buttonNo1.hidden = true
        buttonNo2.hidden = true
        buttonNo3.hidden = true
        buttonNo4.hidden = true
        buttonNo5.hidden = true
        mainMenuButton.hidden = true
        
        quizTile1.enabled = true
        quizTile2.enabled = true
        quizTile3.enabled = true
        quizTile4.enabled = true
        quizTile5.enabled = true
        quizTile6.enabled = true
        quizTile7.enabled = true
        quizTile8.enabled = true
        quizTile9.enabled = true
        quizTile10.enabled = true
        quizMainMenu.enabled = true
        scoreTile.enabled = false
        
        quizTile1.hidden = false
        quizTile2.hidden = false
        quizTile3.hidden = false
        quizTile4.hidden = false
        quizTile5.hidden = false
        quizTile6.hidden = false
        quizTile7.hidden = false
        quizTile8.hidden = false
        quizTile9.hidden = false
        quizTile10.hidden = false
        quizMainMenu.hidden = false
        scoreTile.hidden = false
        
        quizTile1.setTitle("?", forState: .Normal)
        quizTile2.setTitle("?", forState: .Normal)
        quizTile3.setTitle("?", forState: .Normal)
        quizTile4.setTitle("?", forState: .Normal)
        quizTile5.setTitle("?", forState: .Normal)
        quizTile6.setTitle("?", forState: .Normal)
        quizTile7.setTitle("?", forState: .Normal)
        quizTile8.setTitle("?", forState: .Normal)
        quizTile9.setTitle("?", forState: .Normal)
        quizTile10.setTitle("?", forState: .Normal)
        
        scoreTile.setBackgroundImage(UIImage(named: "emptyTile.png"), forState: .Normal)
        scoreTile.setTitle("0 / 100\rpoints", forState: .Disabled)

        codeChallengeLogo.hidden = true
        logoButton.hidden = true
        logoButton.enabled = false
        
        animateQuizButtons()
        
    }
    
    //Animation of Quiz Buttons
    func animateQuizButtons() {
        quizTile1.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.5, delay: 0.9, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile1.transform = CGAffineTransformIdentity }, completion: nil
        )
        
        quizTile2.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.6, delay: 0.8, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile2.transform = CGAffineTransformIdentity }, completion: nil
        )
        
        quizTile3.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.4, delay: 0.7, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile3.transform = CGAffineTransformIdentity }, completion: nil
        )
        
        quizTile4.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile4.transform = CGAffineTransformIdentity }, completion: nil
        )
        
        quizTile5.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.6, delay: 0.3, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile5.transform = CGAffineTransformIdentity }, completion: nil
        )
        
        quizTile6.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.3, delay: 0.4, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile6.transform = CGAffineTransformIdentity }, completion: nil
        )
        
        quizTile7.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.7, delay: 0.3, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile7.transform = CGAffineTransformIdentity }, completion: nil
        )
        
        quizTile8.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.6, delay: 0.3, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile8.transform = CGAffineTransformIdentity }, completion: nil
        )
        
        quizTile9.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile9.transform = CGAffineTransformIdentity }, completion: nil
        )
        
        quizTile10.transform = CGAffineTransformMakeScale(0, 0)
        UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
            self.quizTile10.transform = CGAffineTransformIdentity }, completion: nil
        )
        
    }
    
    
    func randomNumber() -> Double {
        let randomNumber = Double(arc4random_uniform(1))
        return randomNumber
    }
    
}

