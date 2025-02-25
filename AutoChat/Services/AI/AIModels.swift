import Foundation

/// AI请求模型
struct AIRequestModel: Encodable {
    let model: String
    let messages: [AIMessageModel]
    let maxTokens: Int
    let temperature: Double
    let stream: Bool
    
    enum CodingKeys: String, CodingKey {
        case model
        case messages
        case maxTokens = "max_tokens"
        case temperature
        case stream
    }
}

/// AI消息模型
struct AIMessageModel: Encodable {
    let role: String
    let content: String
    
    init(from message: AIMessage) {
        self.role = message.role.rawValue
        self.content = message.content
    }
}

/// AI响应模型
struct AIResponseModel: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [AIChoiceModel]
}

/// AI选择模型
struct AIChoiceModel: Decodable {
    let index: Int
    let delta: AIDeltaModel?
    let message: AIMessageResponseModel?
    let finishReason: String?
    
    enum CodingKeys: String, CodingKey {
        case index
        case delta
        case message
        case finishReason = "finish_reason"
    }
}

/// AI增量响应模型
struct AIDeltaModel: Decodable {
    let role: String?
    let content: String?
}

/// AI消息响应模型
struct AIMessageResponseModel: Decodable {
    let role: String
    let content: String
}

/// AI流式响应模型
struct AIStreamResponseModel: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [AIChoiceModel]
}