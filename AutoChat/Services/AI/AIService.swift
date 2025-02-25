import Foundation
import Combine

/// AI服务的错误类型
enum AIServiceError: Error {
    case invalidResponse
    case networkError(Error)
    case contextLimitExceeded
    case invalidAPIKey
    case rateLimitExceeded
    case serverError(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "无效的响应数据"
        case .networkError(let error):
            return "网络错误: \(error.localizedDescription)"
        case .contextLimitExceeded:
            return "对话上下文超出限制"
        case .invalidAPIKey:
            return "无效的API密钥"
        case .rateLimitExceeded:
            return "请求频率超出限制"
        case .serverError(let message):
            return "服务器错误: \(message)"
        }
    }
}

/// AI消息的角色类型
enum AIRole: String {
    case system
    case user
    case assistant
}

/// AI消息结构
struct AIMessage {
    let role: AIRole
    let content: String
    let timestamp: Date
    
    init(role: AIRole, content: String) {
        self.role = role
        self.content = content
        self.timestamp = Date()
    }
}

/// AI服务配置
struct AIConfiguration {
    let apiKey: String
    let model: String
    let maxTokens: Int
    let temperature: Double
    
    static let `default` = AIConfiguration(
        apiKey: "",  // 需要从环境配置中获取
        model: "gpt-3.5-turbo",
        maxTokens: 2000,
        temperature: 0.7
    )
}

/// AI服务协议
protocol AIServiceProtocol {
    /// 发送消息并获取流式响应
    func sendMessage(_ message: String, context: [AIMessage]) -> AnyPublisher<String, AIServiceError>
    
    /// 中止当前进行中的对话
    func stopCurrentChat()
    
    /// 清理对话上下文
    func clearContext()
}

/// AI服务实现
class AIService: AIServiceProtocol {
    private let configuration: AIConfiguration
    private var currentTask: Task<Void, Never>?
    
    init(configuration: AIConfiguration = .default) {
        self.configuration = configuration
    }
    
    func sendMessage(_ message: String, context: [AIMessage]) -> AnyPublisher<String, AIServiceError> {
        // TODO: 实现消息发送和流式响应处理
        fatalError("需要实现消息发送和流式响应处理")
    }
    
    func stopCurrentChat() {
        currentTask?.cancel()
        currentTask = nil
    }
    
    func clearContext() {
        // TODO: 实现上下文清理逻辑
    }
    
    private func validateContext(_ context: [AIMessage]) -> Bool {
        // TODO: 实现上下文验证逻辑
        return true
    }
    
    private func handleError(_ error: Error) -> AIServiceError {
        // TODO: 实现错误处理逻辑
        return .networkError(error)
    }
}