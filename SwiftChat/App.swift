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
    
    
    func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocket) {
        print("didReceive")
        
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            print("Received text: \(string)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error)
        }
    }
    
    func writeText(string: String) {
        socket.write(string: string) {
            return
        }
    }
    
    func disconnect() {
        if isConnected {
            print("Connect")
            socket.disconnect()
            
        } else {
            print("Disconnect")
            socket.connect()
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }
    
    override init() {
        super.init()
        
        var request = URLRequest(url: URL(string: "ws://192.168.1.73:8080/chat")!) //https://localhost:8080
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        
    }
   
    
    let font: UIFont? = .systemFont(ofSize: 26)
    var phone: String = "" {
        didSet {
            UserDefaults.standard.set(phone, forKey: "phone")
        }
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
}
