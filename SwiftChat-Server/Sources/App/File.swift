//
//  File.swift
//  
//
//  Created by MacBook on 22.08.2022.
//

import Vapor
import Foundation

class ChatRoom {
    var connections: [String: WebSocket]
    
    init() {
        connections = [:]
    }
    
    func send(name: String, message: String) {
        
    }
    
}
