//
//  Home.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 02/11/2023.
//

import SwiftUI

struct Home: View {
    // DATA
    @EnvironmentObject var topicsManager: TopicsManager
    
    // Tab View State
    @State var selectedTab = 0
    
    // Scene Phase Manager to handle saving
    @Environment(\.scenePhase) private var scenePhase
    let saveAction : () -> Void
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                
                let questions = topicsManager.allQuestions
                let topics = topicsManager.allTopics
                
                ForEach(topics, id: \.id) { topic in
                   ForEach(0..<topic.questions.count, id: \.self) { index in
                       QuizView(vm: QuizView.ViewModel(topic: topic.name.capitalized, question: questions[index]), selectedTab: $selectedTab)
                            .tag(index)
                    }
                }
            }
            .onChange(of: scenePhase) { phase in
                print("Scene phase changed: \(phase)")
                if phase == .inactive {
                    saveAction()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onAppear {
                HapticManager.shared.prepareHaptic()
                UIScrollView.appearance().isScrollEnabled = false
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink("Topics") {
                        UserProfilView()
                            .environmentObject(topicsManager)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink("Test View") {
                        topicsTestView()
                            .environmentObject(topicsManager)
                    }
                }
            }
        }
    }
}

#Preview {
    Home(saveAction: {})
        .environmentObject(TopicsManager.shared)
}
