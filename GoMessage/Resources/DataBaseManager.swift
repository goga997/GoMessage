//
//  DataBaseManager.swift
//  GoMessage
//
//  Created by Grigore on 28.12.2023.
//

import Foundation
import FirebaseDatabase

final class DataBaseManager {
    static let shared = DataBaseManager()
    private let dataBase = Database.database().reference()
}

extension DataBaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        dataBase.child(safeEmail).observeSingleEvent(of: .value) { snapShot in
            guard snapShot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    /// Inserts new User to dataBase
    public func inserUser(with user: ChatAppUser) {
        dataBase.child(user.safeEmail ).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }

}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAdress: String
    
    var safeEmail: String {
        var safeEmail = emailAdress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    //    let profilePicture: String
}
