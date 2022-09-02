import Fluent
import Vapor

var connections: [String: WebSocket] = [:]

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.webSocket("chat") { req, ws in
            // Connected WebSocket.
            print(ws)
            ws.send("You have connected to WebSocket")
        connections["name"] = ws
            
            ws.onBinary { ws, bytebuffer in
                print("connected")
            }
            
            ws.onText { ws, string in
                print(string)
                
                for (_, connection) in connections {
                    connection.send(string)
                }
                
            }
            
            ws.onClose.whenSuccess { _ in
                print("disconnected")
            }
        }

    try app.register(collection: TodoController())
}
