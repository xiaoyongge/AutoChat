import SwiftUI

struct NavigationBar: View {
    var title: String
    var leftItems: [NavigationBarButton]?
    var rightItems: [NavigationBarButton]?
    
    var body: some View {
        HStack(spacing: 16) {
            // 左侧按钮组
            HStack(spacing: 12) {
                if let leftItems = leftItems {
                    ForEach(leftItems) { item in
                        item
                    }
                }
            }
            
            Spacer()
            
            // 标题
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            // 右侧按钮组
            HStack(spacing: 12) {
                if let rightItems = rightItems {
                    ForEach(rightItems) { item in
                        item
                    }
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 44)
        .background(
            Color(.systemBackground)
                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        )
    }
}

struct NavigationBarButton: View, Identifiable {
    var id = UUID()
    var icon: String?
    var title: String?
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
            }
            if let title = title {
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
            }
        }
    }
}

#Preview {
    NavigationBar(
        title: "聊天",
        leftItems: [
            NavigationBarButton(icon: "arrow.left") { print("Back tapped") }
        ],
        rightItems: [
            NavigationBarButton(icon: "square.and.pencil") { print("Edit tapped") },
            NavigationBarButton(icon: "ellipsis") { print("More tapped") }
        ]
    )
}