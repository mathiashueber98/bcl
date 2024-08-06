//
//  StorageManager.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//





import SwiftUI
import RealmSwift


class StorageManager {
    
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    @ObservedResults(User.self) var users
    @ObservedResults(LoungeReservation.self) var reservations

    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    func createReservation(date: String, time: String, duration: String, players: String, additionInfo: String, name: String, number: String, email: String, club: String) {
        let reserv = LoungeReservation()
        reserv.date = date
        reserv.time = time
        reserv.selectedHour = duration
        reserv.players = players
        reserv.additionInfo = additionInfo
        reserv.name = name
        reserv.number = number
        reserv.email = email
        reserv.club = club
        
        try! realm.write {
            realm.add(reserv)
        }
    }
    
    func createUser() {
        let user = User()
        user.code = DataManager.shared.generateUserCode()
        user.level = "1"
        user.credits = 0
        
        try! realm.write {
            realm.add(user)
        }
    }
    
    func getUser() -> User {
        let users = realm.objects(User.self)
        if let user = users.first {
            return user
        } else {
            return User()
        }
        
    }
    
    func updateUser(name: String, surname: String, email: String, birthday: String, number: String) {
        let users = realm.objects(User.self)
        if let realmUser = users.first {
            try! realm.write {
                realmUser.name = name
                realmUser.surname = surname
                realmUser.email = email
                realmUser.birthday = birthday
                realmUser.phone = number
            }
            print("User updated")
        }
    }
    
    func updateUserScore(level: String, credits: Int) {
        let users = realm.objects(User.self)
        if let realmUser = users.first {
            try! realm.write {
                realmUser.level = level
                realmUser.credits = credits
            }
            print("User updated")
        }
    }
}
