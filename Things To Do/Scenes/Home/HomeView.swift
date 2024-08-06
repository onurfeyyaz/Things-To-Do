//
//  ContentView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 23.06.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var isChecked = false
    
    var body: some View {
        NavigationSplitView {
            VStack {
                if viewModel.toDoItems.isEmpty {
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .frame(width: 175, height: 175, alignment: .center)
                        .padding(.bottom)
                    Text(Constants.HomeView.emptyViewMessage)
                        .multilineTextAlignment(.center)
                }
                else {
                    List {
                        ForEach(viewModel.toDoItems) { item in
                            HStack {
                                Text(item.title)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .strikethrough(item.isCompleted)
                                
                                Button(action: {
                                    if let index = viewModel.toDoItems.firstIndex(where: { $0.id == item.id }) {
                                        viewModel.isToDoCompleted(index)
                                    }
                                }) {
                                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(item.isCompleted ? .green : .gray)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .padding(.vertical, 8)
                        }
                        .onDelete(perform: { indexSet in
                            viewModel.removeData(index: indexSet)
                        })
                    }
                }
            }
            .navigationTitle(viewModel.toDoItems.isEmpty ? "" : Constants.HomeView.navigationTitleDoIt)
            .onAppear {
                //viewModel.loadData()
            }
        } detail: {
            Text(Constants.HomeView.navigationTitleDetailforIpad)
        }
    }
}
#Preview {
    HomeView()
}
