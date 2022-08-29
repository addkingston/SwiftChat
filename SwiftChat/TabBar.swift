//
//  TabBar.swift
//  SwiftChat
//
//  Created by MacBook on 10.08.2022.
//

import UIKit

class TabBar: UITabBarController, UITabBarControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let tabBar = { () -> CustomTabBar in
                    let tabBar = CustomTabBar()
                    tabBar.delegate = self
                    return tabBar
                }()
                
                self.setValue(tabBar, forKey: "tabBar")
    
        
        let vc1 = DialogsVC()
        vc1.view.backgroundColor = .systemRed
        let tabItem1 = UITabBarItem(title: "Chats", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.badge.filled.fill"))
        vc1.tabBarItem = tabItem1
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .black
        let tabItem2 = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gearshape.fill"))
        vc2.tabBarItem = tabItem2
        
        
        
        
        
//        message.badge
//        message.badge.filled.fill
//        message
//        message.fill
//        paperplane.fill
//        paperplane.circle.fill
//        gear
//        gearshape
//        gearshape.fill
        
        
        
        viewControllers = [vc1, vc2]
    }
}

