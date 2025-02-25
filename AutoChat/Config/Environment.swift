import Foundation

enum Environment {
    case development
    case staging
    case production
    
    static var current: Environment {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }
    
    var baseURL: String {
        switch self {
        case .development:
            return "https://api-dev.autochat.app"
        case .staging:
            return "https://api-staging.autochat.app"
        case .production:
            return "https://api.autochat.app"
        }
    }
    
    var aiModelEndpoint: String {
        switch self {
        case .development:
            return "/v1/chat/dev"
        case .staging:
            return "/v1/chat/staging"
        case .production:
            return "/v1/chat/prod"
        }
    }
    
    var logLevel: LogLevel {
        switch self {
        case .development:
            return .debug
        case .staging:
            return .info
        case .production:
            return .error
        }
    }
}

enum LogLevel {
    case debug
    case info
    case warning
    case error
}