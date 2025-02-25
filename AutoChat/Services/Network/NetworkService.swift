import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

class NetworkService {
    static let shared = NetworkService()
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 300
        self.session = URLSession(configuration: config)
    }
    
    func request<T: Decodable>(_ endpoint: String,
                              method: String = "GET",
                              body: Data? = nil) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: endpoint) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return session.dataTaskPublisher(for: request)
            .mapError { NetworkError.requestFailed($0) }
            .flatMap { data, response -> AnyPublisher<T, NetworkError> in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
                }
                
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { NetworkError.decodingFailed($0) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func requestStream(_ endpoint: String,
                       method: String = "GET",
                       body: Data? = nil) -> AsyncThrowingStream<Data, Error> {
        AsyncThrowingStream { continuation in
            guard let url = URL(string: endpoint) else {
                continuation.finish(throwing: NetworkError.invalidURL)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.httpBody = body
            
            let task = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.finish(throwing: NetworkError.requestFailed(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    continuation.finish(throwing: NetworkError.invalidResponse)
                    return
                }
                
                if let data = data {
                    continuation.yield(data)
                }
                continuation.finish()
            }
            
            task.resume()
        }
    }
}