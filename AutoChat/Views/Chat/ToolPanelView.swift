import SwiftUI

struct ToolPanelView: View {
    @Binding var isPresented: Bool
    @ObservedObject private var themeManager = ThemeManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("工具面板")
                    .font(.headline)
                Spacer()
                Button(action: { isPresented = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom)
            
            ScrollView {
                VStack(spacing: 16) {
                    toolButton(icon: "person.fill", title: "AI个性化设置") {
                        // TODO: 实现AI个性化设置
                    }
                    
                    toolButton(icon: "paintbrush.fill", title: "主题设置") {
                        // TODO: 实现主题设置
                    }
                    
                    toolButton(icon: "doc.on.doc", title: "导出对话") {
                        // TODO: 实现对话导出
                    }
                    
                    toolButton(icon: "wand.and.stars", title: "AI提示词") {
                        // TODO: 实现AI提示词功能
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(themeManager.currentTheme == .dark ? Color(.systemGray6) : .white)
        .cornerRadius(16)
        .shadow(radius: 10)
    }
    
    private func toolButton(icon: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding()
            .background(themeManager.currentTheme == .dark ? Color(.systemGray5) : Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

#Preview {
    ToolPanelView(isPresented: .constant(true))
        .padding()
        .preferredColorScheme(.light)

    ToolPanelView(isPresented: .constant(true))
        .padding()
        .preferredColorScheme(.dark)
}
