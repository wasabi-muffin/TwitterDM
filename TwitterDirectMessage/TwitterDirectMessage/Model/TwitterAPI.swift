////
////  TwitterAPI.swift
////  TwitterDirectMessage
////
////  Created by Marco Valentino on 12/3/17.
////  Copyright © 2017 Marco Valentino. All rights reserved.
////
//
import Foundation
import Accounts
import Social

class TwitterAPI {
    static let shared = TwitterAPI()
    var account = ACAccountStore()
    lazy var accountType = account.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)

    func getTwitterAccount(completion: @escaping (User) -> Void) {
        account.requestAccessToAccounts(with: accountType, options: nil, completion: {(success, error) in
            if success {
                if let twitterAccount = self.account.accounts(with: self.accountType).last as? ACAccount {
                    let user = User(context: AppDelegate.viewContext)
                    user.username = twitterAccount.username
                    completion(User.getUser(matching: user, in: AppDelegate.viewContext))
                }
            }
        })
    }

    
    func getTwitterFollowers(completion: @escaping (([User]) -> Void)) {
        self.account.requestAccessToAccounts(with: accountType, options: nil, completion: {(success, error) in
            if success {
                if let twitterAccount = self.account.accounts(with: self.accountType).last as? ACAccount {
                    let statusesShowEndpoint = "https://api.twitter.com/1.1/followers/list.json"
                let params = ["screen_name": "@gmvalentino8"]
    
                let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                        requestMethod: SLRequestMethod.GET,
                                        url: URL(string: statusesShowEndpoint),
                                        parameters: params)
                request?.account = twitterAccount
                request?.perform(handler: {(responseData, urlResponse, error) in
                    do {
                        var followers = [User]()
                        let data = try JSONSerialization.jsonObject(with: responseData!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String: Any]
                        let users = data["users"] as! [[String: Any]]
                        for item in users {
                            let username = item["screen_name"] as! String
                            let pictureURL = item["profile_image_url_https"] as! String
                            print("USER: ", item)
                            let follower = User(context: AppDelegate.viewContext)
                            follower.username = username
                            follower.profilePictureURL = pictureURL
                            followers.append(User.getUser(matching: follower, in: AppDelegate.viewContext))
                        }
                        completion(followers)
                    } catch let error as NSError {
                        print("Data serialization error: \(error.localizedDescription)")
                    }
                })
            }
        }
    })
    }
}



