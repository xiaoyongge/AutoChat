import Foundation

struct ChatMessage: Identifiable, Codable {
    let id: UUID
    let content: String
    let timestamp: Date
    let isUserMessage: Bool
    
    init(id: UUID = UUID(), content: String, isUserMessage: Bool = true) {
        self.id = id
        self.content = content
        self.timestamp = Date()
        self.isUserMessage = isUserMessage
    }
}