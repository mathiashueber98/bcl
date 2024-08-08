import SwiftUI
import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    private let realm = try! Realm()
    
    private init() {}
    
    @ObservedResults(User.self) private var users
    @ObservedResults(LoungeReservation.self) private var reservations

    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Failed to delete all data: \(error.localizedDescription)")
        }
    }
    
    func createReservation(date: String, time: String, duration: String, players: String, additionInfo: String, name: String, number: String, email: String, club: String) {
        let reservation = LoungeReservation()
        reservation.date = date
        reservation.time = time
        reservation.selectedHour = duration
        reservation.players = players
        reservation.additionInfo = additionInfo
        reservation.name = name
        reservation.number = number
        reservation.email = email
        reservation.club = club
        
        do {
            try realm.write {
                realm.add(reservation)
            }
        } catch {
            print("Failed to create reservation: \(error.localizedDescription)")
        }
    }
    
    func createUser() {
        let user = User()
        user.code = DataManager.shared.generateUserCode()
        
        do {
            try realm.write {
                realm.add(user)
            }
        } catch {
            print("Failed to create user: \(error.localizedDescription)")
        }
    }
    
    func getUser() -> User {
        let users = realm.objects(User.self)
        return users.first ?? User()
    }
    
    func updateUser(name: String, surname: String, email: String, birthday: String, number: String) {
        let users = realm.objects(User.self)
        guard let realmUser = users.first else { return }
        
        do {
            try realm.write {
                realmUser.name = name
                realmUser.surname = surname
                realmUser.email = email
                realmUser.birthday = birthday
                realmUser.phone = number
            }
            print("User updated successfully")
        } catch {
            print("Failed to update user: \(error.localizedDescription)")
        }
    }
}
