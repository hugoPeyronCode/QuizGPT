//
//  QuizViewModel.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 02/11/2023.
//

import Foundation
import SwiftUI

enum QuizState {
    case neutral
    case selected
    case correct
    case wrong
}

extension QuizView {
    class ViewModel : ObservableObject {
        
        // Initiatilising Data. Topic and Question
        var topic: String
        var question: Question
                
        init(topic: String, question: Question) {
            self.topic = topic
            self.question = question
            setup(with: topic, question: question)
        }
        
        // Properties
        @Published var quizState: QuizState = .neutral
        @Published var selectedItems: [String] = []
        @Published var isShowingModal: Bool = false
        @Published var duoOptions: [String] = []
                
        func setup(with topic: String, question: Question) {
            self.topic = topic
            self.question = question
            updateDuoOptions(with: question.answer, from: question.possibleAnswers)
        }
        
        func moveToNextQuestion(currentTab: Binding<Int>) {
            if currentTab.wrappedValue < TopicsManager.shared.allQuestions.count - 1 {
                currentTab.wrappedValue += 1
            }
            // You may also need to update the question here after moving to the next one
        }
        
        
        func validateAnswer() {
            let answer = selectedItems.first!
            let goodAnswer = question.answer
            checkResult(goodAnswer: goodAnswer, answer: answer)
            question.upgrade()
        }
        
        func toggleModal() {
            isShowingModal.toggle()
        }
        
        func checkResult(goodAnswer: String, answer: String) {
            if goodAnswer == answer {
                quizState = .correct
                isShowingModal = true
                question.upgrade()
                HapticManager.shared.generateFeedback(for: .successStrong)
            } else {
                quizState = .wrong
                HapticManager.shared.generateFeedback(for: .errorStrong)
                // Then 5 seconds later it becomes back to neutral.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isShowingModal = true
                    self.quizState = .wrong
                }
            }
        }
        
        // Function to initialize or update the duo options
        func updateDuoOptions(with correctAnswer: String, from possibleAnswers: [String]) {
            var options = possibleAnswers.filter { $0 != correctAnswer }
            options.shuffle()
            // Get one incorrect answer
            let incorrectAnswer = options.first!
            // Return both answers, shuffled
            duoOptions = [correctAnswer, incorrectAnswer].shuffled()
        }
    }
}


struct QuizManager {

    static let shared = QuizManager()
    
    func color(quizState: QuizState) -> Color {
        switch quizState {
        case .neutral:
            return .gray
        case .selected:
            return .mint
        case .correct:
            return .green
        case .wrong:
            return .pink
        }
    }
}
