//
//  ViewController.swift
//  SwiftChat
//
//  Created by Admin on 06.06.2022.
//

import UIKit

class GreetingsVC: UIViewController {
    
    let screen = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backGroundImageView)
        view.addSubview(getStartedButton)
        view.addSubview(imageView1)
        view.addSubview(imageView2)
        view.addSubview(imageView3)
        view.addSubview(imageView4)
        
        view.addSubview(containerView)
        containerView.addSubview(getStartedButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
    }
    lazy var backGroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.view.bounds
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 50, y: 100, width: 140, height: 110)
        imageView.image = UIImage.image1
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .sand
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 200, y: 100, width: 140, height: 180)
        imageView.image = UIImage(named: "alien")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .darkPink
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 50, y: 225, width: 140, height: 180)
        imageView.image = UIImage(named: "alien2")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.backgroundColor = .cloud
        return imageView
    }()
    
    lazy var imageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 200, y: 295, width: 140, height: 110)
        imageView.image = UIImage(named: "bored")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .cloud
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.frame = CGRect(x: 0, y: screen.height - 270, width: screen.width, height: 260)
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true

        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 10, width: screen.width, height: 70)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Enjoy the new experience of\nchatting with global friends"
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 40, width: screen.width, height: 100)
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "Connect people around the world for free"
        label.textAlignment = .center
        
        
        return label
    }()
    
    
    
    lazy var getStartedButton: UIButton = {
        let button = UIButton()
        
        button.frame = CGRect(x: 24, y: 160, width: screen.width - 50, height: 70)
        button.setTitle("Get Started", for: .normal)
        button.setBackgroundColor(.pink, for: .normal)
        button.setBackgroundColor(.salat, for: .highlighted)
        button.addTarget(self, action: #selector(showAuth), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.withAlphaComponent(0.9).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 20
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        
        return button
    }()
    
    @objc func showAuth() {
        let vc = AutorizationVC()
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true) {
            print("presented AuthorizationVC")
        }
    }
    
    


}

