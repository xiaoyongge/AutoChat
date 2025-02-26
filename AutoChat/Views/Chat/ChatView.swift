import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var messageText = ""
    @State private var showToolPanel = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        MessageBubbleView(message: message)
                            .id(message.id)
                    }
                }
                .padding()
            }
            
            VStack(spacing: 0) {
                QuickActionBar(
                    onImageTap: { /* TODO: 实现图片上传 */ },
                    onVoiceTap: { /* TODO: 实现语音输入 */ },
                    onMoreTap: { showToolPanel = true }
                )
                
                HStack(alignment: .bottom) {
                    TextEditor(text: $messageText)
                        .frame(height: min(100, max(40, CGFloat(messageText.count / 20 * 20))))
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                    }
                    .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .background(Color(.systemBackground))
        }
        .navigationTitle("对话")
        .sheet(isPresented: $showToolPanel) {
            ToolPanelView(isPresented: $showToolPanel)
        }
    }
    
    private func sendMessage() {
        let trimmedText = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        viewModel.sendMessage(trimmedText)
        messageText = ""
    }
}

#Preview {
    ChatView()
}