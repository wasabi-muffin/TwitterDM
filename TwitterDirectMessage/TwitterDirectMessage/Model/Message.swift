//
//  Message.swift
//  TwitterDirectMessage
//
//  Created by Marco Valentino on 12/3/17.
//  Copyright © 2017 Marco Valentino. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class Message: NSManagedObject {
    
    static func getSentMessages(user: User, in context: NSManagedObjectContext) -> [Message] {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "fromUser = %@", user)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print(error.localizedDescription)
        }
        return [Message]()
    }
    
    static func getReceivedMessages(user: User, in context: NSManagedObjectContext) -> [Message] {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "toUser = %@", user)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print(error.localizedDescription)
        }
        return [Message]()
    }
    
    static func getMessages(between fromUser: User, and toUser: User, in context: NSManagedObjectContext) -> [Message] {
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "fromUser.username = %@ && toUser.username = %@", fromUser.username!, toUser.username!)
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print(error.localizedDescription)
        }
        return [Message]()
    }
    
    static func sendMessage(from fromUser: User, to toUser: User, content: String, in context: NSManagedObjectContext) -> Message{
        let message = Message(context: context)
        message.fromUser = User.getUser(matching: fromUser, in: AppDelegate.viewContext)
        message.toUser = User.getUser(matching: toUser, in: AppDelegate.viewContext)
        message.content = content
        message.timestamp = Date()
        return message
    }
    
    
//    static func getMessages(from fromUser: String, to toUser: String) -> [Message] {
//        let message1 = Message(from: "Marco", to: "Riku", message: "Good Morning...", time: Date())
//        let message2 = Message(from: "Marco", to: "Riku", message: "Hello, how are you? Hope you are having a good morning", time: Date())
//        let message3 = Message(from: "Marco", to: "Riku", message: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchaes with us", time: Date())
//        let message4 = Message(from: "Marco", to: "Riku", message: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchaes with us", time: Date())
//        let message5 = Message(from: "Marco", to: "Riku", message: "Are you interested in buying an Apple device? We have a wide variety of Apple devices that will suit your needs. Please make your purchaes with us", Date())
//
//        return [message1, message2, message3, message4, message5]
//    }
    
}
