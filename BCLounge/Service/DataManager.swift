//
//  DataManager.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createInitialData() {
        if !UserDefaults.standard.bool(forKey: "initial") {
            UserDefaults.standard.setValue(true, forKey: "initial")
            StorageManager.shared.createUser()
            print("Initial Created")
        }
    }
    
    func generateUserCode() -> String {
        var randomNumbers = ""
        for _ in 0..<4 {
            let randomNumber = Int.random(in: 0...99)
            randomNumbers += String(format: "%02d", randomNumber) + " "
        }
        randomNumbers.removeLast()
        return randomNumbers
    }
}
