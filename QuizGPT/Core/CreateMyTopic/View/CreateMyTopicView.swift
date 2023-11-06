//
//  CreateMyTopicView.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 04/11/2023.
//

import SwiftUI
struct CreateMyTopicView: View {
    
    @State var topicName : String = ""
    @State var questions: [Question] = []
    
    @State var question : String = ""
    @State var answer : String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Create your own topic")
                    .font(.title)
                
                TextField("Name of the topic", text: $topicName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                
                    VStack {
                        TextField("Question", text: $question)
                        TextField("Good Answer", text: $answer)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                
                Button(action: {
                           self.questions.append(Question(question: question , possibleAnswers: ChatGPTManager.shared.generateAnswers(for: answer), answer: answer, explanation: ChatGPTManager.shared.generateExplanation(for: answer)))
                        question = ""
                        answer = ""
                }) {
                    Text("Save Question")
                }
                .disabled(question.isEmpty || answer.isEmpty)
                
                ForEach(questions, id: \.id) { question in
                    VStack {
                        Text(question.question)
                        Text(question.answer)
                    }
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    CreateMyTopicView()
}


class ChatGPTManager {
    static let shared = ChatGPTManager()
    
    func generateAnswers(for : String) -> [String] {
        return ["I need", "To code", "This function"]
    }
    
    func generateExplanation(for: String) -> String {
        return "I also need to code this function"
    }
}
