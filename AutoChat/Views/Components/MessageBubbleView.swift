import SwiftUI

struct MessageBubbleView: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUserMessage {
                Spacer()
            }
            
            Text(message.content)
                .padding(12)
                .background(message.isUserMessage ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(message.isUserMessage ? .white : .primary)
                .cornerRadius(16)
                .contextMenu {
                    Button(action: {
                        UIPasteboard.general.string = message.content
                    }) {
                        Label("复制", systemImage: "doc.on.doc")
                    }
                }
            
            if !message.isUserMessage {
                Spacer()
            }
        }
    }
}

#Preview {
    MessageBubbleView(message: ChatMessage(content: "这是一条测试消息"))
        .padding()
}