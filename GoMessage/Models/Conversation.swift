//
//  Conversation.swift
//  GoMessage
//
//  Created by Grigore on 08.01.2024.
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let otherUSerEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
