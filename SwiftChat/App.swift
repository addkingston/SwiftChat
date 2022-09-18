//
//  File.swift
//  SwiftChat
//
//  Created by MacBook on 20.06.2022.
//

import UIKit
import Starscream

let app = App()

class App: NSObject, WebSocketDelegate {
    
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    
    let font: UIFont? = .systemFont(ofSize: 26)
    var phone: String = "" {
        didSet {
            UserDefaults.standard.set(phone, forKey: "phone")
        }
    }
    
    override init() {
        super .init()
        
        var request = URLRequest(url: URL(string: "ws://192.168.1.73:8080/chat")!)
        request.timeoutInterval = 2
        request.addValue("Mr", forHTTPHeaderField: "name")
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    
    let apiKey = "5X5693A8ET3CA89DSS9QACF03781C2J3YT81I9C2PD79OAD857SCH56B77E1CN6D"
    var randomCode = Int.random(in: 1000...9999)
    
    func requestSMSCode(phone: String, complete: () -> Void) {
         
         let text = "SwiftChat\nCode: \(randomCode)"
         
        Just.get("https://smspilot.ru/api.php", params: ["send": text, "to": phone, "apikey": apiKey], asyncCompletionHandler:  {
            response in
            print(phone)
            
        })
        complete()
    }
    
    func sendSMSCode(code: String, complete: () -> Void) {
        
//         let text = "SwiftChat\nCode: \(randomCode)"
//
//        Just.get("https://smspilot.ru/api.php", params: ["send": text, "to": code, "apikey": apiKey], asyncCompletionHandler:  {
//            response in
//            print(code)
//
//        })
        complete()
    }

    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        
        switch event {
        case .connected(let headers):
            isConnected = true
        case .disconnected(let reason, let code):
            isConnected = false
        case .text(let string):
            NotificationCenter.default.post(name: .gotMessage, object: nil, userInfo: ["text" : string])
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            
        default: break
        }
    }
    
    func writeText(string: String) {
        socket.write(string: string) {
            return
        }
    }
    
    func disconnect() {
        if isConnected {
            socket.disconnect()
        } else {
            socket.connect()
        }
    }    
}
