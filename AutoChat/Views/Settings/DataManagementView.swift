import SwiftUI

struct DataManagementView: View {
    @State private var showingExportSheet = false
    @State private var showingImportSheet = false
    @State private var showingDeleteAlert = false
    @State private var storageSize: String = "计算中..."
    
    var body: some View {
        Form {
            Section(header: Text("存储信息")) {
                HStack {
                    Text("已用空间")
                    Spacer()
                    Text(storageSize)
                }
            }
            
            Section(header: Text("数据操作")) {
                Button(action: { showingExportSheet = true }) {
                    Label("导出聊天记录", systemImage: "square.and.arrow.up")
                }
                
                Button(action: { showingImportSheet = true }) {
                    Label("导入聊天记录", systemImage: "square.and.arrow.down")
                }
                
                Button(action: { showingDeleteAlert = true }) {
                    Label("清理所有数据", systemImage: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("数据管理")
        .alert("确认删除", isPresented: $showingDeleteAlert) {
            Button("取消", role: .cancel) { }
            Button("删除", role: .destructive) {
                // 实现数据删除逻辑
            }
        } message: {
            Text("此操作将清除所有聊天记录和设置，且无法恢复。")
        }
        .sheet(isPresented: $showingExportSheet) {
            // 导出视图
            Text("导出功能")
        }
        .sheet(isPresented: $showingImportSheet) {
            // 导入视图
            Text("导入功能")
        }
        .onAppear {
            // 计算存储空间
            calculateStorageSize()
        }
    }
    
    private func calculateStorageSize() {
        // 实现存储空间计算逻辑
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            storageSize = "1.2 MB"
        }
    }
}

struct DataManagementView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DataManagementView()
        }
    }
}