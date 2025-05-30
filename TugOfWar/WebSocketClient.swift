//
//  WebSocketClient.swift
//  TugOfWar
//
//  Created by Kate Wang on 5/29/25.
//

import Foundation

class WebSocketClient {
    private var webSocketTask: URLSessionWebSocketTask?
    
    
    func connect(onMessage:  @escaping (String) -> Void) {
        let url = URL(string: "ws://localhost:80")! 
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        receive(onMessage: onMessage)
        
    }

    func receive(onMessage:  @escaping (String) -> Void) {
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print("❌ Error: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("📨 Received: \(text)")
                    onMessage(text)
                case .data(let data):
                    print("📨 Received binary: \(data)")
                @unknown default:
                    print("⚠️ Unknown message")
                }
            }
            self.receive(onMessage: onMessage)
        }
        
    }

    func send(text: String) {
        let message = URLSessionWebSocketTask.Message.string(text)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("❌ Send error: \(error)")
            }
        }
    }

    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
}

