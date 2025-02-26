import SwiftUI

enum ThemeMode {
    case light
    case dark
    case system
}

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var currentTheme: ThemeMode = .system
    @Published var accentColor: Color = .blue
    
    private init() {}
    
    // 主色调
    var primary: Color {
        switch currentTheme {
        case .light:
            return .black
        case .dark:
            return .white
        case .system:
            return Color(uiColor: UIColor { $0.userInterfaceStyle == .dark ? .white : .black })
        }
    }
    
    // 背景色
    var background: Color {
        switch currentTheme {
        case .light:
            return Color(uiColor: .systemBackground)
        case .dark:
            return Color(uiColor: .systemBackground)
        case .system:
            return Color(uiColor: .systemBackground)
        }
    }
    
    // 次要背景色
    var secondaryBackground: Color {
        switch currentTheme {
        case .light:
            return Color(uiColor: .secondarySystemBackground)
        case .dark:
            return Color(uiColor: .secondarySystemBackground)
        case .system:
            return Color(uiColor: .secondarySystemBackground)
        }
    }
    
    // 分组背景色
    var groupedBackground: Color {
        switch currentTheme {
        case .light:
            return Color(uiColor: .systemGroupedBackground)
        case .dark:
            return Color(uiColor: .systemGroupedBackground)
        case .system:
            return Color(uiColor: .systemGroupedBackground)
        }
    }
    
    // 文本颜色
    var text: Color {
        switch currentTheme {
        case .light:
            return .black
        case .dark:
            return .white
        case .system:
            return Color(uiColor: UIColor { $0.userInterfaceStyle == .dark ? .white : .black })
        }
    }
    
    // 次要文本颜色
    var secondaryText: Color {
        switch currentTheme {
        case .light:
            return .gray
        case .dark:
            return .gray
        case .system:
            return .gray
        }
    }
    
    // 切换主题
    func setTheme(_ theme: ThemeMode) {
        currentTheme = theme
    }
    
    // 设置强调色
    func setAccentColor(_ color: Color) {
        accentColor = color
    }
}