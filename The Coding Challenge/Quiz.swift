//
//  Quiz.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 14.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

public struct Quiz {
    
    var questions = [Question]()
    
    var name: String?
    var introText: String?
    var iconName: String?
    var forTutorial: String?
    var endQuizText: String?
    var questionsDict: Array<NSDictionary>?
    //initialisation.
    init(dictionary: NSDictionary) {
        
        let name = dictionary["name"] as? String
        let introText = dictionary["introText"] as? String
        let iconName = dictionary["iconName"] as? String
        let forTutorial = dictionary["forTutorial"] as? String
        let endQuizText = dictionary["endQuizText"] as? String
        let questionsDict = dictionary["quizquestions"] as! Array<NSDictionary>

        self.name = name
        self.introText = introText
        self.iconName = iconName
        self.forTutorial = forTutorial
        self.endQuizText = endQuizText
        self.iconName = iconName
        self.questionsDict = questionsDict
        
        self.questions = questionsDict.map(Question.init).flatMap({ $0 })
        
    }
}

public struct Question {
    
    public var question: String?
    public var option1: String?
    public var option2: String?
    public var option3: String?
    public var option4: String?
    public var correctOption: Int?
    public var correctAnswerText: String?
    // initialisation.
    public init?(dictionary: NSDictionary) {
        let question = dictionary["question"] as? String
        let option1 = dictionary["option1"] as? String
        let option2 = dictionary["option2"] as? String
        let option3 = dictionary["option3"] as? String
        let option4 = dictionary["option4"] as? String
        let correctOption = dictionary["correctOption"] as? Int
        let correctAnswerText = dictionary["correctAnswerText"] as? String
        
        self.question = question
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.option4 = option4
        self.correctOption = correctOption
        self.correctAnswerText = correctAnswerText
        
    }
    
}
