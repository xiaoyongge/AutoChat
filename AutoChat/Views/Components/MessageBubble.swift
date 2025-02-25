import SwiftUI

struct MessageBubble: View {
    enum MessageType {
        case user
        case ai
    }
    
    var message: String
    var type: MessageType
    var timestamp: Date
    
    private var backgroundColor: Color {
        switch type {
        case .user:
            return Color.blue.opacity(0.2)
        case .ai:
            return Color(.systemGray6)
        }
    }
    
    private var alignment: Alignment {
        type == .user ? .trailing : .leading
    }
    
    var body: some View {
        VStack(alignment: alignment == .trailing ? .trailing : .leading, spacing: 4) {
            HStack {
                if type == .ai {
                    Image(systemName: "brain")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                }
                
                Text(message)
                    .padding(12)
                    .background(backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: alignment)
                
                if type == .user {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 16))
                }
            }
            
            Text(timestamp.formatted(.dateTime.hour().minute()))
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: alignment)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
}

#Preview {
    VStack {
        MessageBubble(
            message: "你好，我是AI助手，有什么可以帮你的吗？",
            type: .ai,
            timestamp: Date()
        )
        
        MessageBubble(
            message: "请帮我解释一下SwiftUI的视图修饰符。",
            type: .user,
            timestamp: Date()
        )
    }
    .padding()
}