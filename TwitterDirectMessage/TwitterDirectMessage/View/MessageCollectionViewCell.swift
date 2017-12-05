//
//  CollectionViewCell.swift
//  TwitterDirectMessage
//
//  Created by Marco Valentino on 12/3/17.
//  Copyright © 2017 Marco Valentino. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        return textView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    static let leftBubbleImage = UIImage(named: "left_bubble")!.resizableImage(withCapInsets: UIEdgeInsets(top: 16, left: 28, bottom: 16, right: 20)).withRenderingMode(.alwaysTemplate)
    static let rightBubbleImage = UIImage(named: "right_bubble")!.resizableImage(withCapInsets: UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 32)).withRenderingMode(.alwaysTemplate)

    let bubbleImageView = UIImageView()
    
    func setupViews() {
        addSubview(textBubbleView)
        addSubview(messageTextView)
        textBubbleView.addSubview(bubbleImageView)
        textBubbleView.addConstraintsFillEntireView(view: bubbleImageView)
    }
    
}
