//
//  Topic.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 03/11/2023.
//

import Foundation
import SwiftUI

struct Topic : Identifiable, Codable {
    let id : UUID
    let name: String
    let questions : [Question]
    var progress : Double {
        return Double(questions.filter { $0.questionState == .validated }.count) / Double(questions.count)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, questions
    }
    
    init(id: UUID = UUID(), name: String, questions: [Question]) {
        self.id = id
        self.name = name
        self.questions = questions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        name = try container.decode(String.self, forKey: .name)
        questions = try container.decode([Question].self, forKey: .questions)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(questions, forKey: .questions)
    }
}
