//
//  CashViewModel.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 05/11/2023.
//

import Foundation
import SwiftUI
//
//enum CashViewState {
//    case isCorrect, isNeutral, isWritting, isWrong
//}

extension CashView {
    class ViewModel: ObservableObject {
        @Published var userInput: String = ""
        @Published var result  : Bool?
        
        let answer: String
        
        init(answer: String) {
            self.answer = answer.uppercased()
        }
        
        func characterAtIndex(_ index: Int) -> String {
                 guard index < userInput.count else { return " " }
                 let stringIndex = userInput.index(userInput.startIndex, offsetBy: index)
                 return String(userInput[stringIndex])
             }
        
        func checkAnswer() {
            if userInput.count == answer.count { // Add this condition
                if userInput.lowercased() == answer.lowercased() {
                    result = true
                } else {
                    result = false
                }
            }
        }
        
        func color(result : Bool?) -> Color {
            if userInput.count == answer.count {
                switch result {
                case true :
                    return .green
                case false :
                    return .red
                default :
                    return .gray
                }
            } else  {
                return .gray
            }
        }
    }
}
