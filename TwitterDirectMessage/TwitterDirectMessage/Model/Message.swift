//
//  Message.swift
//  TwitterDirectMessage
//
//  Created by Marco Valentino on 12/3/17.
//  Copyright © 2017 Marco Valentino. All rights reserved.
//

import Foundation

class Message {
    var fromUser: String
    var toUser: String
    var content: String
    var timestamp: String
    
    init(from fromUser: String, to toUser: String, message: String, time: String) {
        self.fromUser = fromUser
        self.toUser = toUser
        self.content = message
        self.timestamp = time
    }
    
    static func getMessages(from fromUser: String, to toUser: String) -> [Message] {
        let formatter = DateFormatter()
        let message1 = Message(from: "Marco", to: "Riku", message: "Good Morning...", time: formatter.string(from: Date()))
        let message2 = Message(from: "Marco", to: "Riku", message: "Hello, how are you? Hope you are having a good morning", time: formatter.string(from: Date()))
        let message3 = Message(from: "Marco", to: "Riku", message: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchaes with us", time: formatter.string(from: Date()))
        let message4 = Message(from: "Marco", to: "Riku", message: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchaes with us", time: formatter.string(from: Date()))
        let message5 = Message(from: "Marco", to: "Riku", message: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchaes with us", time: formatter.string(from: Date()))

        return [message1, message2, message3, message4, message5]
    }
    
}
