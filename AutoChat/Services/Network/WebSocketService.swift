import Foundation

enum WebSocketError: Error {
    case connectionFailed(Error)
    case invalidURL
    case messageEncodingFailed
    case connectionClosed
    case sendFailed(Error)
}

class WebSocketService {
    static let shared = WebSocketService()
    
    private var webSocket: URLSessionWebSocketTask?
    private let session: URLSession
    
    private var isConnected = false
    private var messageHandler: ((Result<String, Error>) -> Void)?
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: config)
    }
    
    func connect(to endpoint: String) {
        guard let url = URL(string: endpoint) else {
            messageHandler?(.failure(WebSocketError.invalidURL))
            return
        }
        
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()
        isConnected = true
        
        receiveMessage()
    }
    
    func disconnect() {
        webSocket?.cancel(with: .normalClosure, reason: nil)
        webSocket = nil
        isConnected = false
    }
    
    func send(message: String) {
        guard isConnected else {
            messageHandler?(.failure(WebSocketError.connectionClosed))
            return
        }
        
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocket?.send(message) { [weak self] error in
            if let error = error {
                self?.messageHandler?(.failure(WebSocketError.sendFailed(error)))
            }
        }
    }
    
    func setMessageHandler(_ handler: @escaping (Result<String, Error>) -> Void) {
        self.messageHandler = handler
    }
    
    private func receiveMessage() {
        webSocket?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.messageHandler?(.success(text))
                case .data(let data):
                    if let text = String(data: data, encoding: .utf8) {
                        self?.messageHandler?(.success(text))
                    }
                @unknown default:
                    break
                }
                
                // 继续接收下一条消息
                self?.receiveMessage()
                
            case .failure(let error):
                self?.messageHandler?(.failure(WebSocketError.connectionFailed(error)))
                self?.disconnect()
            }
        }
    }
}