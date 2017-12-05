//
//  Follower.swift
//  TwitterDirectMessage
//
//  Created by Marco Valentino on 12/3/17.
//  Copyright © 2017 Marco Valentino. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class User: NSManagedObject {
    
    static func getUser(matching username: String, profilePictureURL: String, in context: NSManagedObjectContext) -> User {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "username = %@", username)
        
        do {
            let result = try context.fetch(request)
            if result.count > 0 {
                print("TEST ", result.count)
                //assert(result.count < 2, "Database inconsistency")
                print("TEST Got User ", result[0].username)
                return result[0]
            }
        } catch {
            print("TEST Error")
        }
        print("TEST Creating new user")
        let newUser = User(context: context)
        newUser.username = username
        newUser.profilePictureURL = profilePictureURL
        try? context.save()
        return newUser
    }
}
