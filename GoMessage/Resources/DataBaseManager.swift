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
    
    static func safeEmail(emailAdress: String) -> String {
        var safeEmail = emailAdress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}

// MARK: - Account Mgmt
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
    public func insertUser(with user: ChatAppUser, completion: @escaping (Bool) -> Void) {
        dataBase.child(user.safeEmail ).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ]) { error, _ in
            guard error == nil else {
                print("failed ot write to database")
                completion(false)
                return
            }
            
            self.dataBase.child("users").observeSingleEvent(of: .value) { snapshot in
                if var usersCollection = snapshot.value as? [[String: String]] {
                    //append to user dictionary
                    let newElement =   [
                        "name": user.firstName + " " + user.lastName,
                        "email": user.safeEmail
                    ]
                    usersCollection.append(newElement)
                    self.dataBase.child("users").setValue(usersCollection) { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)
                    }
                } else {
                    //create that array
                    let newCollection: [[String: String]] = [["name": user.firstName + " " + user.lastName, "email": user.safeEmail]]
                    self.dataBase.child("users").setValue(newCollection) { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)
                    }
                }
            }
            completion(true)
        }
    }
     
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void) {
        dataBase.child("users").observeSingleEvent(of: .value) { snapshot in
            if !snapshot.exists() {
                print("no user found")
            }
            guard let value = snapshot.value as? [[String:String]] else {
                completion(.failure(DataBaseError.failledToFetch))
                return
            }
            
            completion(.success(value))
        }
    }
    
    public enum DataBaseError: Error {
        case failledToFetch
    }
}

//MARK: - Sending Messages / Conversations
extension DataBaseManager {
    ///Creates a new conversation with target user emamil and first message sent
    public func createNewConversation(with otherUserErmail: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
        
    }
    
    /// Fetches and returns all conversations for the user with passed in email
    public func getAllConversations(for email: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    public func getAllMessagesForConversation(with id: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    /// Sends a message with target conversation and message
    public func sendMessage(to conversation: String, message: Message, completion: @escaping (Bool) -> Void ) {
        
    }
    
}

