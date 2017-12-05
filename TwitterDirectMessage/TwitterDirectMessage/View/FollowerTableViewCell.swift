//
//  FollowerTableViewCell.swift
//  TwitterDirectMessage
//
//  Created by Marco Valentino on 12/3/17.
//  Copyright © 2017 Marco Valentino. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!

    func loadImageWithUrlString(_ urlStringOptional: String?) {
        
        guard let urlString = urlStringOptional else {
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if let error = error { print(error); return }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    self.profileImage.image = downloadedImage
                    UIView.animate(withDuration: 0.2, animations: {
                        self.profileImage.alpha = 1
                    })
                    
                }
            })
            
        }).resume()
    }
}
