import SwiftUI

struct MessageBubbleView: View {
    let message: ChatMessage
    
    private var timestampFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var body: some View {
        VStack(alignment: message.isUserMessage ? .trailing : .leading, spacing: 4) {
            HStack {
                if message.isUserMessage {
                    Spacer()
                }
                
                VStack(alignment: message.isUserMessage ? .trailing : .leading, spacing: 8) {
                    Text(message.content)
                        .padding(12)
                        .background(message.isUserMessage ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(message.isUserMessage ? .white : .primary)
                        .cornerRadius(16)
                    
                    Text(timestampFormatter.string(from: message.timestamp))
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                if !message.isUserMessage {
                    Spacer()
                }
            }
            .contextMenu {
                Button(action: {
                    UIPasteboard.general.string = message.content
                }) {
                    Label("复制", systemImage: "doc.on.doc")
                }
                
                Button(action: {
                    // TODO: 实现消息转发功能
                }) {
                    Label("转发", systemImage: "arrowshape.turn.up.right")
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    MessageBubbleView(message: ChatMessage(content: "这是一条测试消息"))
        .padding()
}