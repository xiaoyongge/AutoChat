import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // 初始化时加载历史消息
        loadMessages()
    }
    
    func sendMessage(_ content: String) {
        let userMessage = ChatMessage(content: content)
        messages.append(userMessage)
        
        // TODO: 调用AI服务获取响应
        // 模拟AI响应
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let aiMessage = ChatMessage(content: "这是一个模拟的AI响应", isUserMessage: false)
            self.messages.append(aiMessage)
        }
    }
    
    private func loadMessages() {
        // TODO: 从本地存储加载历史消息
    }
    
    private func saveMessages() {
        // TODO: 保存消息到本地存储
    }
}