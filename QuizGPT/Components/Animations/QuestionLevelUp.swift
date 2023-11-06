//
//  QuestionLevelUp.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 06/11/2023.
//

import SwiftUI


struct QuestionLevelUp: View {
    
    
    @State var result : Bool
    let questionState : QuestionState = .duo
    @State var progressValue = 1.0
    
    var body: some View {
        HStack {
            Image(systemName: "shield")
                .foregroundStyle(.blue)
            ProgressView(value: progressValue, total: 100)
                .tint(Gradient(colors: [.blue, .yellow]))
            Image(systemName: "shield.fill")
                .foregroundStyle(.yellow)
            
        }
        .padding(.horizontal)
        .onAppear {
            if result == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        self.progressValue = 100
                    }
                }
            }
        }
    }
}
    #Preview {
        QuestionLevelUp(result: true)
    }
