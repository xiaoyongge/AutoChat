import SwiftUI

struct QuickActionBar: View {
    var onImageTap: () -> Void
    var onVoiceTap: () -> Void
    var onMoreTap: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: onImageTap) {
                Image(systemName: "photo")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
            
            Button(action: onVoiceTap) {
                Image(systemName: "mic")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
            
            Button(action: onMoreTap) {
                Image(systemName: "ellipsis")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(.systemGray4))
                .offset(y: -0.25),
            alignment: .top
        )
    }
}

#Preview {
    QuickActionBar(
        onImageTap: {},
        onVoiceTap: {},
        onMoreTap: {}
    )
}