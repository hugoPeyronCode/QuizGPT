//
//  TopicsManager.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 03/11/2023.
//

import Foundation
class TopicsManager : ObservableObject {
    
    static let shared = TopicsManager()
    
    var topicsfileNames : [String] = ["general", "history", "geography"]
    
    @Published var allTopics: [Topic] = [] {
        didSet {
            SaveDataManager.shared.saveTopics(allTopics)
        }
    }
    @Published var allQuestions : [Question] = []
    
    private init() {
        loadTopics()
        loadAllQuestions()
    }
    
    private func loadTopics() {
        if let savedTopics = SaveDataManager.shared.loadTopics() {
            print("using saved Topics")
            allTopics = savedTopics
        } else {
            // Load topics from bundled JSON files if no saved data exists
            for topic in topicsfileNames {
                print("using JSON Parser")
                let name = topic
                let questions = JSONParser.parseQuestions(from: topic) ?? []
                allTopics.append(Topic(name: name, questions: questions))
            }
        }
    }
    
    private func loadAllQuestions() {
        for topic in allTopics {
            for question in topic.questions {
                allQuestions.append(question)
            }
        }
    }
}
