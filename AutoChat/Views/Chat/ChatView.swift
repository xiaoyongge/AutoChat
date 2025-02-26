import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        MessageBubbleView(message: message)
                            .id(message.id)
                    }
                }
                .padding()
            }
            
            HStack {
                TextField("输入消息...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
        .navigationTitle("对话")
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        viewModel.sendMessage(messageText)
        messageText = ""
    }
}

#Preview {
    ChatView()
}