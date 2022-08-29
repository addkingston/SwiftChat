//
//  DialogCell.swift
//  SwiftChat
//
//  Created by MacBook on 27.07.2022.
//

import UIKit

struct Dialog {
    
    var name = ""
    var image = ""
    var lastMessageText = ""
    
    var timesStamp = " "
    var unreadMessagesCount = 0

}

class DialogsCell: UITableViewCell {
    
    let screen = UIScreen.main.bounds
    
    var dialog: Dialog? {
        didSet {
            if let name = dialog?.name{
                titleLabel.text = name
            }
            if let image = dialog?.image{
                avatar.image = UIImage(named: image)
                print(image)
            }
            if let lastMessageText = dialog?.lastMessageText{
                subtitleLabel.text = lastMessageText
            }
            if let timesStamp = dialog?.timesStamp{
                timeStampLabel.text = timesStamp
            }
            if let unreadMessagesCount = dialog?.unreadMessagesCount{
                if unreadMessagesCount < 1 {
                    unreadCountLabel.alpha = 0.0
                } else {
                    unreadCountLabel.text = String(unreadMessagesCount)
                    unreadCountLabel.alpha = 1.0
                }
            }
        }
    }
    
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        
        addSubview(avatar)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(timeStampLabel)
        addSubview(unreadCountLabel)
    }
    
  lazy var avatar: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "")
        img.frame = CGRect(x: 16, y: 12, width: 64, height: 64)
        img.layer.cornerRadius = 32
        img.layer.masksToBounds = true
      
        return img
  }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 88, y: 12, width: screen.width - 150, height: 30)
        label.font = .systemFont(ofSize: 27, weight: .bold)
        label.text = "String"
        label.textColor = .white
//        label.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return label
        
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 88, y: 12 + 34, width: screen.width - 150, height: 30)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "String"
        label.textColor = .lightText
//        label.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return label
        
    }()
    
    lazy var timeStampLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: screen.width - 50, y: 12, width: 50, height: 30)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "12:54"
        label.textColor = .lightText
//        label.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return label
        
    }()
    
    lazy var unreadCountLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: screen.width - 45, y: 46, width: 20, height: 20)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "1"
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
//        label.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return label
        
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
