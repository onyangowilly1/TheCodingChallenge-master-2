//
//  QuizStore.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 14.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

public protocol JSONQuizSourceDelegate {
    func quizDataIsLoaded()
    func quizLoadingFailed(errorMessage: String)
}

public class QuizStore {
    
    internal var delegate: JSONQuizSourceDelegate?
    internal var count: Int {
        return quiz.count
    }
    
    subscript(index: Int) -> Quiz {
        return quiz[index]
    }
    
    private var session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    private var quiz = [Quiz]()
    
    // Fetching Quiz from the server/JSON.
    public func loadQuizData() {
        let JSONFileURL = NSBundle.mainBundle().URLForResource("quiz", withExtension: ".json")!
        let task = session.dataTaskWithURL(JSONFileURL) { (data, response, error) in
            guard let data = data else {
                self.failed("Quiz: Data did not come back from the server")
                return
            }
            
            guard let json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? NSDictionary else {
                self.failed("Quiz: Data from the server was not valid JSON")
                return
            }
            
            guard let quizInfo = json["quiz"] as? Array<NSDictionary> else {
                self.failed("Quiz: The JSON format from the server changed!")
                return
            }
            
            self.quiz = quizInfo.map(Quiz.init).flatMap({ $0 })
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.delegate?.quizDataIsLoaded()
            })
        }
        task.resume()
    }
    
    private func failed(message: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock({
            self.delegate?.quizLoadingFailed(message)
        })
        return
    }
    
}
