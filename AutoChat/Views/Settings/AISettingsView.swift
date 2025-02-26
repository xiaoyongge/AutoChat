import SwiftUI

struct AISettingsView: View {
    @AppStorage("selectedModel") private var selectedModel = "GPT-4"
    @AppStorage("temperature") private var temperature = 0.7
    @AppStorage("maxTokens") private var maxTokens = 2000
    
    private let models = ["GPT-4", "GPT-3.5-turbo"]
    
    var body: some View {
        Form {
            Section(header: Text("模型设置")) {
                Picker("AI模型", selection: $selectedModel) {
                    ForEach(models, id: \.self) { model in
                        Text(model).tag(model)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("温度: \(String(format: "%.1f", temperature))")
                    Slider(value: $temperature, in: 0...1) {
                        Text("温度")
                    }
                }
                
                Stepper("最大Token数: \(maxTokens)", value: $maxTokens, in: 100...4000, step: 100)
            }
            
            Section(header: Text("个性化"), footer: Text("较高的温度值会使回答更有创意，较低的温度值会使回答更加精确。")) {
                Toggle("启用记忆功能", isOn: .constant(true))
                Toggle("自动补全", isOn: .constant(true))
            }
        }
        .navigationTitle("AI设置")
    }
}

struct AISettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AISettingsView()
        }
    }
}