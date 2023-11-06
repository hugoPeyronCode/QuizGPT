//
//  SaveDataManager.swift
//  QuizGPT
//
//  Created by Hugo Peyron on 03/11/2023.
//

import Foundation

class SaveDataManager {
    
    static let shared = SaveDataManager()
    
    private init() { }
    
    private var fileURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("SavedData.json")
    }
    
    func saveTopics(_ topics: [Topic]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(topics)
            try data.write(to: fileURL)
            print("Data saved successfully.")
            print("File URL: \(fileURL)")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    func loadTopics() -> [Topic]? {
        guard let data = try? Data(contentsOf: fileURL) else {
            print("No data found at \(fileURL)")
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            let topics = try decoder.decode([Topic].self, from: data)
            print("Data loaded successfully.")
            return topics
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
            return nil
        }
    }
}
