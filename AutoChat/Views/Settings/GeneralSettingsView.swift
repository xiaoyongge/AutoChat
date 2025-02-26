import SwiftUI

struct GeneralSettingsView: View {
    @AppStorage("enableNotifications") private var enableNotifications = true
    @AppStorage("autoUpdate") private var autoUpdate = true
    @AppStorage("saveHistory") private var saveHistory = true
    @AppStorage("fontSize") private var fontSize = 16.0
    
    var body: some View {
        Form {
            Section(header: Text("通知")) {
                Toggle("启用通知", isOn: $enableNotifications)
            }
            
            Section(header: Text("更新")) {
                Toggle("自动检查更新", isOn: $autoUpdate)
            }
            
            Section(header: Text("聊天")) {
                Toggle("保存聊天历史", isOn: $saveHistory)
                
                VStack(alignment: .leading) {
                    Text("字体大小: \(Int(fontSize))")
                    Slider(value: $fontSize, in: 12...24) {
                        Text("字体大小")
                    }
                }
            }
            
            Section(header: Text("关于")) {
                HStack {
                    Text("版本")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.gray)
                }
                
                NavigationLink(destination: Text("隐私政策内容")) {
                    Text("隐私政策")
                }
                
                NavigationLink(destination: Text("用户协议内容")) {
                    Text("用户协议")
                }
            }
        }
        .navigationTitle("通用设置")
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GeneralSettingsView()
        }
    }
}