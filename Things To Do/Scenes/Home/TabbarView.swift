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
    @StateObject private var addToDoViewModel = AddToDoViewModel()
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            TabView(selection: $router.selectedTab) {
                HomeView(viewModel: homeViewModel)
                    .tabItem {
                        Label(Constants.Tabbar.listView, systemImage: "list.bullet")
                    }
                    .tag(0)
                    .badge(homeViewModel.toDoItems.count)
                
                AddToDoView(viewModel: addToDoViewModel)
                    .tabItem {
                        Label(Constants.Tabbar.addView, systemImage: "plus.circle")
                    }
                    .tag(1)
                
                ProfileView(toDoItems: homeViewModel.toDoItems)
                    .tabItem {
                        Label(Constants.Tabbar.profileView, systemImage: "person")
                    }
                    .tag(2)
            }
            .navigationDestination(for: Router.Destination.self) { destination in
                switch destination {
                case .home:
                    HomeView(viewModel: homeViewModel)
                case .add:
                    AddToDoView(viewModel: addToDoViewModel)
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    TabbarView()
}
