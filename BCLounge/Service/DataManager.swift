//
//  DataManager.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import Foundation

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createInitialData() {
        let isInitialCreated = UserDefaults.standard.bool(forKey: "initial")
        guard !isInitialCreated else { return }
        
        UserDefaults.standard.setValue(true, forKey: "initial")
        StorageManager.shared.createUser()
        print("Initial data created")
    }
    
    func generateUserCode() -> String {
        let randomNumbers = (0..<4).map { _ in
            String(format: "%02d", Int.random(in: 0...99))
        }.joined(separator: " ")
        
        return randomNumbers
    }
}

