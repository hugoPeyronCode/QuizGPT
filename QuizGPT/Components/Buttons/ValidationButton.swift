//
//  ValidateButton.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 03/11/2023.
//

import SwiftUI

struct ValidateButton : View {
    @Binding var quizState : QuizState
    let action : () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            Text(quizState == .correct ? "Good Job!" : "Validate")
                .font(.title3)
                .frame(width: 300, height: 60)
                .background(QuizManager.shared.color(quizState: quizState).opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding(5)
                .foregroundStyle(QuizManager.shared.color(quizState: quizState))
        }
    }
}

#Preview {
    ValidateButton(quizState: .constant(.correct), action: {})
}
