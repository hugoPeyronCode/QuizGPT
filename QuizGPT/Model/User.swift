//
//  User.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 03/11/2023.
//

import Foundation
import SwiftUI

class User {
    let id : UUID = UUID()
    let name : String
    var xp : Int
    var level : UserLevel

    init(name: String, xp: Int, level: UserLevel) {
        self.name = name
        self.xp = xp
        self.level = level
    }
    func moveToNextLevel() {
        let newLevelIndex = xp / 100
        if newLevelIndex < UserLevel.allCases.count {
            // It should trigger some kind of event.
            level = UserLevel.allCases[newLevelIndex]
        }
    }
}

enum UserLevel : String, CaseIterable {
    case Freshman
    case Sophomore
    case Junior
    case Senior
    case Bachelor
    case Master
    case Doctor
    case Professor
    
    var icon: String {
        switch self {
        case .Freshman:
            return "freshmanIcon"
        case .Sophomore:
            return "sophomoreIcon"
        case .Junior:
            return "juniorIcon"
        case .Senior:
            return "seniorIcon"
        case .Bachelor:
            return "bachelorIcon"
        case .Master:
            return "masterIcon"
        case .Doctor:
            return "doctorIcon"
        case .Professor:
            return "professorIcon"
        }
    }
    
    var color: Color {
        switch self {
        case .Freshman:
            return .gray
        case .Sophomore:
            return .cyan
        case .Junior:
            return .mint
        case .Senior:
            return .orange
        case .Bachelor:
            return .green
        case .Master:
            return .purple
        case .Doctor:
            return .pink
        case .Professor:
            return .yellow
        }
    }
}
