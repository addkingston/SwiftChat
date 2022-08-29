//
//  File.swift
//  SwiftChat
//
//  Created by MacBook on 11.07.2022.
//

import UIKit


class MessageCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        backgroundColor = .clear
        tintColor = .white
        
        addSubview(containerView)
        containerView.addSubview(messageLabel)
        
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        view.layer.cornerRadius = 12
        return view
    }()
    
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 8, y: 4, width: 200, height: 40)
        label.textColor = .black
        label.font = app.font
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
