//
//  ContentView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 23.06.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        let userDefaultsHelper = UserDefaultsHelper<ToDoItem>(userDefaultsKey: Constants.toDoItemsKey)
        _viewModel = StateObject(wrappedValue: HomeViewModel(userDefaultsHelper: userDefaultsHelper))
    }
    
    @State private var newToDoTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField(Constants.Content.addTextToTextField, text: $newToDoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        guard !newToDoTitle.isEmpty else { return }
                        
                        viewModel.addToDoItem(title: newToDoTitle)
                        newToDoTitle = ""
                        
                    }) {
                        Text(Constants.Content.add)
                    }
                }
                .padding()
                
                List {
                    ForEach(viewModel.toDoItems) { item in
                        HStack {
                            Text(item.title)
                        }
                    }
                }
            }
            .navigationTitle(Constants.appName)
        }
    }
}
#Preview {
    HomeView()
}
