//
//  QuizGPTApp.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 02/11/2023.
//

import SwiftUI

@main
struct QuizGPTApp: App {
    
    let topicsManager : TopicsManager = TopicsManager.shared
    
    var body: some Scene {
        WindowGroup {
            
//            CashView(answer: "Napoleon")
            
            Home() { SaveDataManager.shared.saveTopics(topicsManager.allTopics) }
                .environmentObject(topicsManager)
        }
    }
    func saveData() {
        SaveDataManager.shared.saveTopics(topicsManager.allTopics)
    }
}
