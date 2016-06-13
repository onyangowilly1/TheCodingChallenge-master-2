//
//  Tutorial.swift
//  newTestRegEx
//
//  Created by Jarle Matland on 08.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

public struct Tutorial {
    
    public var tutorialDictionary = [String: AnyObject]()
    public var challenges = [Challenge]()
    
    public var name: String?
    public var iconName: String?
    public var introText: String?
    public var challengeDict: Array<NSDictionary>?
    public var endText: String?
    
    // initialisation
    public init?(dictionary: NSDictionary) {
        let name = dictionary["name"] as? String
        let iconName = dictionary["iconName"] as? String
        let introText = dictionary["introText"] as? String
        let challengeDict = dictionary["challenges"] as! Array<NSDictionary>
        let endText = dictionary["endTutorialText"] as? String
        
        self.name = name
        self.iconName = iconName
        self.introText = introText
        self.challengeDict = challengeDict
        self.endText = endText
        
        self.challenges = challengeDict.map(Challenge.init).flatMap({ $0 })
        
    }
}

public struct Challenge {
    
    public var text: String?
    public var code: String?
    public var input1: String?
    public var input2: String?
    public var input3: String?
    public var imageToDisplay: String?
    public var correctInput: Int?
    public var codeToExecute: String?
    public var correctAnswerText: String?
    // initialisation.
    public init?(dictionary: NSDictionary) {
        let text = dictionary["text"] as? String
        let code = dictionary["code"] as? String
        let input1 = dictionary["input1"] as? String
        let input2 = dictionary["input2"] as? String
        let input3 = dictionary["input3"] as? String
        let correctInput = dictionary["correctInput"] as? Int
        let imageToDisplay = dictionary["imageToDisplay"] as? String
        let codeToExecute = dictionary["codeToExecute"] as? String
        let correctAnswerText = dictionary["correctAnswerText"] as? String
        
        self.text = text
        self.code = code
        self.input1 = input1
        self.input2 = input2
        self.input3 = input3
        self.correctInput = correctInput
        self.imageToDisplay = imageToDisplay
        self.codeToExecute = codeToExecute
        self.correctAnswerText = correctAnswerText
        
    }
    
}
