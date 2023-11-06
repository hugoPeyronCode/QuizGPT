//
//  SingleSelectButton.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 02/11/2023.
//

import SwiftUI

struct SingleSelectButton: View {
    let content: String
    let fontString: String
    @Binding var selectedItems: [String]
    @Binding var quizState: QuizState
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 50)
                .strokeBorder(QuizManager.shared.color(quizState: quizState), lineWidth: isSelected() ? 3 : 1)
                .background(RoundedRectangle(cornerRadius: 50).fill(QuizManager.shared.color(quizState: quizState).opacity(isSelected() ? 0.2 : 0)))
                .overlay {
                    Text(content)
                        .foregroundStyle(.foreground)
                        .font(.custom(fontString, size: 20))
                        .fontWeight(.black)
                }
                .frame(width: 350, height: 60)
                .padding(.horizontal)
//                .animation(.easeInOut, value: isSelected()) // Animate the selection state
//                .animation(.easeInOut, value: quizState) // Animate the quiz state changes
        }
    }
    
    func isSelected() -> Bool {
        selectedItems.contains(content)
    }
}

#Preview {
    SingleSelectButton(content: "Example",fontString: "default", selectedItems: .constant(["Bob"]), quizState: .constant(.correct), action: {})
}
