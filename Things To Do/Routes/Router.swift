//
//  Router.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 19.07.2024.
//

import SwiftUI

final class Router: ObservableObject {
    enum Destination: Codable, Hashable {
        case home
        case add
    }
    
    @Published var navPath = NavigationPath()
    @Published var selectedTab: Int = 0
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath = NavigationPath()
    }
    
    func openTab(_ tab: Destination) {
        switch tab {
        case .home:
            selectedTab = 0
        case .add:
            selectedTab = 1
        }
        navigateToRoot()
    }
}
