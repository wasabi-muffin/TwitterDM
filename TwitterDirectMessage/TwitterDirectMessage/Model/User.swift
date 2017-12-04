//
//  Follower.swift
//  TwitterDirectMessage
//
//  Created by Marco Valentino on 12/3/17.
//  Copyright © 2017 Marco Valentino. All rights reserved.
//

import Foundation

class User {
    var username : String
    var profilePictureURL: String
    
    init() {
        self.username = "gmvalentino8"
        self.profilePictureURL = "test"
    }
    
    init(username: String, picture: String) {
        self.username = username
        self.profilePictureURL = picture
    }
    
    func getFollowers() -> [User] {
        let follower1 = User(username: "Marco", picture: "https://scontent-ort2-1.xx.fbcdn.net/v/t31.0-8/18921041_10158991808350413_2463046042387096864_o.jpg?oh=d7c48fd52645e60f52c54b3a981227ea&oe=5A901D06")
        let follower2 = User(username: "Riku", picture: "https://scontent-ort2-1.xx.fbcdn.net/v/t1.0-9/22688667_1868741953166115_3756908642981688821_n.jpg?oh=f8a07e3acbcb287cd9b2ace9f7ae61ea&oe=5A8FA7DB")
        let follower3 = User(username: "Shin", picture: "https://scontent-ort2-1.xx.fbcdn.net/v/t31.0-8/23213194_10208031426343073_4430538868575702279_o.jpg?oh=acd9359d66626a5be7f9f71ccc62d26a&oe=5A93464E")
     
        return [follower1, follower2, follower3]
    }
}
