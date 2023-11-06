//
//  TopicsTestVie.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 03/11/2023.
//

import SwiftUI

import SwiftUI

struct topicsTestView : View {
    
    @EnvironmentObject var topicsManager: TopicsManager

    var body: some View {
        NavigationStack {
            List {
                
                let topics = topicsManager.allTopics
                
                ForEach(topics, id: \.id) { topic in
                    NavigationLink(destination: VStack {
                        ScrollView {
                            HStack {
                                Text("Question")
                                Spacer()
                                Text("Answer")
                                Spacer()
                                Text("Is Mastered")
                            }
                            .padding()
                            
                            ForEach(topic.questions, id: \.id) { question in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(question.question)
                                            Text(question.answer)
                                            Text("\(question.questionState.rawValue)")
                                            Spacer()
                                        }
                                        .padding()
                                    }
                            }
                        }
                    }) {
                        Text(topic.name)
                    }
                }
            }
        }
    }
}

#Preview(body: {
    topicsTestView()
        .environmentObject(TopicsManager.shared)
})
