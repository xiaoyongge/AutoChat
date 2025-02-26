import SwiftUI

public struct SettingsView: View {
    @StateObject private var themeManager: ThemeManager = ThemeManager.shared
    
    public var body: some View {
        NavigationView {
            List {
                Section(header: Text("AI设置")) {
                    NavigationLink(destination: AISettingsView()) {
                        Label("AI个性化设置", systemImage: "brain")
                    }
                }
                
                Section(header: Text("外观")) {
                    NavigationLink(destination: ThemeSettingsView()) {
                        Label("主题设置", systemImage: "paintpalette")
                    }
                }
                
                Section(header: Text("数据")) {
                    NavigationLink(destination: DataManagementView()) {
                        Label("数据管理", systemImage: "externaldrive")
                    }
                }
                
                Section(header: Text("通用")) {
                    NavigationLink(destination: GeneralSettingsView()) {
                        Label("通用设置", systemImage: "gear")
                    }
                }
            }
            .navigationTitle("设置")
        }
    }
}

// 预览
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
