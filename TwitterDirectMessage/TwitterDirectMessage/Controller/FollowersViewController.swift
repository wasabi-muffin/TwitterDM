//
//  FollowersViewController.swift
//  TwitterDirectMessage
//
//  Created by Marco Valentino on 12/2/17.
//  Copyright © 2017 Marco Valentino. All rights reserved.
//

import UIKit
import Accounts

class FollowersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var user: User?
    
    var followers = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterAPI.shared.getTwitterAccount() { response in
            self.user = response
        }
        TwitterAPI.shared.getTwitterFollowers() { response in
            self.followers = response
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FollowerCell") as! FollowerTableViewCell
        let follower = self.followers[indexPath.row]
        cell.usernameLabel?.text = "@" + follower.username!
        //cell.profileImage.downloadedFrom(link: follower.profilePictureURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = MessagesCollectionViewController(collectionViewLayout: layout)
        controller.user = self.user
        controller.follower = self.followers[indexPath.item]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
    

