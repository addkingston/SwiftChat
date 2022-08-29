//
//  DialogVC.swift
//  SwiftChat
//
//  Created by MacBook on 06.06.2022.
//

import UIKit

class DialogsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    let screen = UIScreen.main.bounds
    
    var selectedRowIndexPath = IndexPath()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.deselectRow(at: selectedRowIndexPath, animated: true)
    }
    
    let dialogs: [Dialog] = [Dialog(name: "Mr. Stranger", image: "ali", lastMessageText: "lalalalallalalalallalalalalalalalalallalaallalaallala", timesStamp: "19:19", unreadMessagesCount: 1), Dialog(name: "Mr.Alien", image: "ali2", lastMessageText: "alallalalalalalalalalalallalalalalalalalallalalalalalalal", timesStamp: "15:41", unreadMessagesCount: 1)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height)
        tableView.backgroundColor = .black
        
        return tableView
    }()
    
    func setupTableView() {
        tableView.register(DialogsCell.self, forCellReuseIdentifier: "DialogCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DialogCell", for: indexPath) as! DialogsCell
        
        cell.dialog = dialogs[indexPath.row]
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        selectedRowIndexPath = indexPath
        
        let chat = ChatVC()
        chat.title = dialogs[indexPath.row].name
        self.navigationController?.pushViewController(chat, animated: true)
    }
    
    
}
