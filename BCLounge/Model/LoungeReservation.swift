//
//  LoungeReservation.swift
//  BCLounge
//
//  Created by admin on 8/6/24.
//



import Foundation
import RealmSwift

class LoungeReservation: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var date = ""
    @Persisted var time = ""
    @Persisted var selectedHour = ""
    @Persisted var players = ""
    @Persisted var additionInfo = ""
    @Persisted var name = ""
    @Persisted var number = ""
    @Persisted var email = ""
    @Persisted var club = ""

}
