//
//  ContentView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 23.06.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var newToDoTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add something to do", text: $newToDoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        guard !newToDoTitle.isEmpty else { return }
                        viewModel.addToDoItem(title: newToDoTitle)
                        newToDoTitle = ""
                    }) {
                        Text("Add")
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
            .navigationTitle("Things To Do")
        }
    }
}
#Preview {
    HomeView()
}