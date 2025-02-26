import SwiftUI

struct ThemeSettingsView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    
    private let colorOptions: [(String, Color)] = [
        ("蓝色", .blue),
        ("红色", .red),
        ("绿色", .green),
        ("紫色", .purple),
        ("橙色", .orange)
    ]
    
    var body: some View {
        Form {
            Section(header: Text("主题模式")) {
                Picker("主题", selection: $themeManager.currentTheme) {
                    Text("跟随系统").tag(ThemeMode.system)
                    Text("浅色").tag(ThemeMode.light)
                    Text("深色").tag(ThemeMode.dark)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("强调色")) {
                ForEach(colorOptions, id: \.0) { name, color in
                    Button(action: {
                        themeManager.setAccentColor(color)
                    }) {
                        HStack {
                            Text(name)
                            Spacer()
                            Circle()
                                .fill(color)
                                .frame(width: 24, height: 24)
                                .overlay(
                                    Circle()
                                        .stroke(themeManager.accentColor == color ? Color.primary : Color.clear, lineWidth: 2)
                                )
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
            
            Section(header: Text("预览")) {
                VStack(spacing: 12) {
                    Text("主要文本")
                        .foregroundColor(themeManager.text)
                    Text("次要文本")
                        .foregroundColor(themeManager.secondaryText)
                    Button("强调色按钮") {}
                        .foregroundColor(themeManager.accentColor)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(themeManager.secondaryBackground)
                        .frame(height: 44)
                        .overlay(
                            Text("背景色预览")
                                .foregroundColor(themeManager.text)
                        )
                }
                .padding()
                .background(themeManager.background)
            }
        }
        .navigationTitle("主题设置")
    }
}

struct ThemeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ThemeSettingsView()
        }
    }
}