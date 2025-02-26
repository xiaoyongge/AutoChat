//
//  ContentView.swift
//  AutoChat
//
//  Created by 吴志勇 on 2025/2/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ChatListView()
            }
            .tabItem {
                Image(systemName: "bubble.left.and.bubble.right")
                Text("聊天")
            }
            .tag(0)
            
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gear")
                Text("设置")
            }
            .tag(1)
        }
    }
}

struct ChatListView: View {
    var body: some View {
        List {
            Text("聊天列表待实现")
        }
        .navigationTitle("聊天")
    }
}

struct SettingsView: View {
    var body: some View {
        List {
            Text("设置界面待实现")
        }
        .navigationTitle("设置")
    }
}

#Preview {
    ContentView()
}
