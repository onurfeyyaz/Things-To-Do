//
//  ContentView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 4.07.2024.
//

import SwiftUI

struct TabbarView: View {
    @StateObject var router = Router()
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        NavigationStack(path: $router.navPath) {
            TabView(selection: $router.selectedTab) {
                HomeView()
                    .tabItem {
                        Label(Constants.Tabbar.listView, systemImage: "list.bullet")
                    }
                    .tag(0)
                    .badge(homeViewModel.toDoItems.count)
                
                AddToDoView(viewModel: AddToDoViewModel())
                    .tabItem {
                        Label(Constants.Tabbar.addView, systemImage: "plus.circle")
                    }
                    .tag(1)
                
                Text("Profile")
                    .tabItem {
                        Label(Constants.Tabbar.profileView, systemImage: "person")
                    }
                    .tag(2)
            }
            .navigationDestination(for: Router.Destination.self) { destination in
                switch destination {
                case .home:
                    HomeView()
                case .add:
                    AddToDoView(viewModel: AddToDoViewModel())
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    TabbarView()
}
