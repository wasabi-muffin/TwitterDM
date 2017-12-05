//
//  MessagesCollectionViewController.swift
//  TwitterDirectMessage
//
//  Created by Marco Valentino on 12/3/17.
//  Copyright © 2017 Marco Valentino. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MessagesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "MessageCell"
    
    var user: User!
    
    var follower: User! {
        didSet {
            navigationItem.title = follower?.username
        }
    }
    var messages: [Message]? {
        didSet {
            collectionView?.reloadData()
            collectionView?.setContentOffset(CGPoint(x: 0, y: self.collectionView!.contentSize.height), animated: false)
        }
    }
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        return view
    }()
    
    let inputTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.font = .systemFont(ofSize: 18)
        textView.sizeToFit()
        textView.layer.cornerRadius = 2
        textView.layer.masksToBounds = true
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return textView
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleSend), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    @objc func handleSend() {
        let text = inputTextView.text!
        let userMessage = Message(content: text, fromUser: user.username, toUser: follower.username)
        self.messages?.append(userMessage)
        self.inputTextView.text = nil
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            let followerMessage = Message(content: text + " " + text, fromUser: self.follower.username, toUser: self.user.username)
            self.messages?.append(followerMessage)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        self.collectionView!.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.messages = [Message]()
        view.addSubview(messageInputContainerView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: messageInputContainerView)
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        setupInputComponents()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.setContentOffset(CGPoint(x: 0, y: self.collectionView!.contentSize.height - view.bounds.height), animated: true)
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            if isKeyboardShowing {
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {}, completion: { result in
                    let viewHeight = self.view.frame.height - keyboardFrame!.height
                    self.collectionView?.setContentOffset(CGPoint(x: 0, y: (self.collectionView?.contentSize.height)! - viewHeight), animated: false)
                })
            }
            bottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
        }
    }
    
    private func setupInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        messageInputContainerView.addSubview(inputTextView)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(topBorderView)
        messageInputContainerView.addConstraintsWithFormat(format: "H:|-4-[v0][v1(80)]-4-|", views: inputTextView, sendButton)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: inputTextView)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0]|", views: sendButton)
        messageInputContainerView.addConstraintsWithFormat(format: "H:|[v0]|", views: topBorderView)
        messageInputContainerView.addConstraintsWithFormat(format: "V:|[v0(0.5)]", views: topBorderView)
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.messages?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCollectionViewCell
        cell.messageTextView.text = messages?[indexPath.item].content
        
        if let message = messages?[indexPath.item] {
            let messageText = message.content
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            // Right Bubble
            if  message.fromUser == user.username {
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 24 - 8 - 4, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.messageTextView.textColor = UIColor.white
                cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 24 - 8 - 16, y: -2, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 4)
                cell.bubbleImageView.image = MessageCollectionViewCell.rightBubbleImage
                cell.bubbleImageView.tintColor = UIColor(red: 77/255, green: 141/255, blue: 238/255, alpha: 1)
            }
            // Left Bubble
            else {
                cell.messageTextView.frame = CGRect(x: 16 + 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                cell.messageTextView.textColor = UIColor.black
                cell.textBubbleView.frame = CGRect(x: 8 + 8, y: -2, width: estimatedFrame.width + 16 + 8 + 16, height: estimatedFrame.height + 20 + 4)
                cell.bubbleImageView.image = MessageCollectionViewCell.leftBubbleImage
                cell.bubbleImageView.tintColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
            }

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let messageText = messages?[indexPath.item].content {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
        }
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 60, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextView.endEditing(true)
        
    }

}
