import SwiftUI

struct LoadingIndicator: View {
    var message: String?
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 12) {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.blue, lineWidth: 2)
                .frame(width: 30, height: 30)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
            
            if let message = message {
                Text(message)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        LoadingIndicator()
        LoadingIndicator(message: "正在思考中...")
    }
}