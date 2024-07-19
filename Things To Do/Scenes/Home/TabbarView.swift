//
//  ContentView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 4.07.2024.
//

import SwiftUI
import SwiftUI

struct TabbarView: View {
    @StateObject var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            TabView(selection: $router.selectedTab) {
                HomeView()
                    .tabItem {
                        Label("List", systemImage: "list.bullet")
                    }
                    .tag(0)
                
                AddToDoView()
                    .tabItem {
                        Label("Add", systemImage: "plus.circle")
                    }
                    .tag(1)
                
                Text("Profile")
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
                    .tag(2)
            }
            .navigationDestination(for: Router.Destination.self) { destination in
                switch destination {
                case .home:
                    HomeView()
                case .add:
                    AddToDoView()
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    TabbarView()
}
