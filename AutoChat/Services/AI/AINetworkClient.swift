import Foundation
import Combine

/// AI网络客户端协议
protocol AINetworkClientProtocol {
    func sendStreamRequest(_ request: AIRequestModel) -> AnyPublisher<AIStreamResponseModel, Error>
    func sendRequest(_ request: AIRequestModel) -> AnyPublisher<AIResponseModel, Error>
}

/// AI网络客户端实现
class AINetworkClient: AINetworkClientProtocol {
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    private let apiKey: String
    private let session: URLSession
    
    init(apiKey: String, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }
    
    func sendStreamRequest(_ request: AIRequestModel) -> AnyPublisher<AIStreamResponseModel, Error> {
        var urlRequest = createURLRequest(for: request)
        urlRequest.setValue("text/event-stream", forHTTPHeaderField: "Accept")
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw AIServiceError.invalidResponse
                }
                
                switch httpResponse.statusCode {
                case 200:
                    return data
                case 401:
                    throw AIServiceError.invalidAPIKey
                case 429:
                    throw AIServiceError.rateLimitExceeded
                default:
                    throw AIServiceError.serverError("HTTP \(httpResponse.statusCode)")
                }
            }
            .flatMap { data -> AnyPublisher<AIStreamResponseModel, Error> in
                let lines = String(decoding: data, as: UTF8.self)
                    .components(separatedBy: "\n")
                    .filter { $0.hasPrefix("data: ") }
                    .compactMap { line -> Data? in
                        let json = line.dropFirst(6)
                        return json.data(using: .utf8)
                    }
                
                return lines.publisher
                    .tryMap { data -> AIStreamResponseModel in
                        try JSONDecoder().decode(AIStreamResponseModel.self, from: data)
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func sendRequest(_ request: AIRequestModel) -> AnyPublisher<AIResponseModel, Error> {
        let urlRequest = createURLRequest(for: request)
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw AIServiceError.invalidResponse
                }
                
                switch httpResponse.statusCode {
                case 200:
                    return data
                case 401:
                    throw AIServiceError.invalidAPIKey
                case 429:
                    throw AIServiceError.rateLimitExceeded
                default:
                    throw AIServiceError.serverError("HTTP \(httpResponse.statusCode)")
                }
            }
            .decode(type: AIResponseModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func createURLRequest(for request: AIRequestModel) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: baseURL)!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = try? JSONEncoder().encode(request)
        return urlRequest
    }
}