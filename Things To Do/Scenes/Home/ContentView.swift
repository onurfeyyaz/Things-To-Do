//
//  ContentView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 4.07.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
            AddToDoView()
                .tabItem {
                    Label("Add", systemImage: "plus.circle")
                }
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}
