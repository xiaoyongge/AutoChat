import Foundation
import Combine

@MainActor
class ChatViewModel: ObservableObject {
    @Published private(set) var messages: [ChatMessage] = []
    @Published private(set) var isProcessing = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMessages()
    }
    
    func sendMessage(_ content: String) {
        guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let userMessage = ChatMessage(content: content)
        messages.append(userMessage)
        saveMessages()
        
        processAIResponse(for: userMessage)
    }
    
    private func processAIResponse(for userMessage: ChatMessage) {
        isProcessing = true
        
        // 模拟AI响应，后续需要替换为实际的AI服务调用
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            
            let aiResponse = ChatMessage(
                content: "这是一个模拟的AI响应\n\n可以包含 **Markdown** 格式\n- 列表项1\n- 列表项2",
                isUserMessage: false
            )
            
            self.messages.append(aiResponse)
            self.saveMessages()
            self.isProcessing = false
        }
    }
    
    private func loadMessages() {
        // TODO: 从本地存储加载历史消息
        // 这里可以添加UserDefaults或CoreData实现
    }
    
    private func saveMessages() {
        // TODO: 保存消息到本地存储
        // 这里可以添加UserDefaults或CoreData实现
    }
    
    func clearChat() {
        messages.removeAll()
        saveMessages()
    }
    
    var lastMessage: ChatMessage? {
        messages.last
    }
    
    var hasMessages: Bool {
        !messages.isEmpty
    }
}