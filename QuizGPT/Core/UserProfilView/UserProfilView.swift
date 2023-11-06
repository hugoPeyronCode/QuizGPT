//
//  UserProfilView.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 03/11/2023.
//

import SwiftUI

enum userDataType : String, CaseIterable {
    case level
    case xp
    case questionAnswered
    case questionMastered
}

struct UserProfilView: View {
    
    @EnvironmentObject var topicsManager: TopicsManager
    
    let user : User = User(name: "Hugo", xp: 50, level: .Junior)
    
    var body: some View {
        ScrollView {
            Image("placeholder")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .ignoresSafeArea()
            
            HStack {
                Text(user.name)
                    .font(.title)
                    .fontWeight(.black)
                    .padding()
                Spacer()
            }
            
            Divider()
            
            VStack {
                HStack {
                    Text("Stats")
                        .fontWeight(.black)
                    Spacer()
                }
                HStack {
                    userInfoButton(type: .level, user: user)
                    userInfoButton(type: .xp, user: user)
                }
                HStack {
                    userInfoButton(type: .questionAnswered, user: user)
                    userInfoButton(type: .questionMastered, user: user)
                }
            }
            .padding()
            
            Divider()
            
            VStack {
//                ProgressView("Total progress", value: 100)
//                    .fontWeight(.black)
                
                let topics = topicsManager.allTopics
                
                ForEach(topics, id: \.id) { topic in
                    HStack {
                        Button {
                            // some code
                        } label: {
                            ProgressView(topic.name, value: topic.progress)
                                .progressViewStyle(.linear)
                                .foregroundStyle(.foreground)
                                .fontWeight(.bold)
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
                
            }
            .padding()
            
        }
    }
}


struct userInfoButton : View {
    
    let type : userDataType
    let user : User
    
    var body: some View {
        Button {
            // Share my level
            HapticManager.shared.generateFeedback(for: .successLight)
        } label: {
            HStack{
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundStyle(color)
                VStack(alignment: .leading) {
                    Text(title)
                        .bold()
                    Text(subtitle)
                        .font(.caption2)
                }
                .foregroundStyle(.foreground)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .frame(height: 60)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
    
    var icon: String {
        switch type {
        case .level:
            return "shield.fill"
        case .xp:
            return "star.fill"
        case .questionAnswered:
            return "questionmark.circle.fill"
        case .questionMastered:
            return "checkmark.circle.fill"
        }
    }
    
    var color: Color {
        switch type {
        case .level:
            return user.level.color
        case .questionAnswered:
            return .orange
        case .questionMastered:
            return .green
        case .xp:
            return .yellow
        }
    }
    
    var title: String {
        switch type {
        case .level:
            return user.level.rawValue
        case .xp:
            return "\(user.xp)"
        case .questionAnswered:
            return "354"
        case .questionMastered:
            return  "654"
        }
    }
    
    var subtitle: String {
        switch type {
        case .level:
            return "Current level"
        case .xp:
            return "XP"
        case .questionAnswered:
            return "Questions Answered"
        case .questionMastered:
            return "Questions Mastered"
        }
    }
}

#Preview {
//    UserProfilView(topics: [Topic(name: "General Knowledge", questions: [Question(question: "test", answer: "", possibleAnswers: [], explanation: "", isMastered: true), Question(question: "", answer: "", possibleAnswers: [], explanation: "", isMastered: false)])])
    UserProfilView()
        .environmentObject(TopicsManager.shared)
}
