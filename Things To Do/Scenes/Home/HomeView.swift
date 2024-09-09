//
//  ContentView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 23.06.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
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
                                    viewModel.toggleCompletion(for: item)
                                }) {
                                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(item.isCompleted ? .green : .gray)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                            .padding(.vertical, Constants.Padding.medium)
                        }
                        .onDelete(perform: { indexSet in
                            if let index = indexSet.first {
                                viewModel.removeData(at: index)
                            }
                            viewModel.loadData()
                        })
                        .onAppear() {
                            viewModel.loadData()
                        }
                    }
                }
            }
            .navigationTitle(viewModel.toDoItems.isEmpty ? "" : Constants.HomeView.navigationTitleDoIt)
        } detail: {
            Text(Constants.HomeView.navigationTitleDetailforIpad)
        }
    }
}
#Preview {
    HomeView(viewModel: HomeViewModel())
}
