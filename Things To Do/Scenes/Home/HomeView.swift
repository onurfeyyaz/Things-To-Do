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
                        .frame(width: Constants.Size.emptyViewImageWidth,
                               height: Constants.Size.emptyViewImageHeight,
                               alignment: .center)
                        .padding(.bottom)
                    Text(Constants.HomeView.emptyViewMessage)
                        .multilineTextAlignment(.center)
                } else {
                    List {
                        ForEach(viewModel.groupedItems(), id: \.self.0) { (key, items) in
                            Section(header: Text(viewModel.sectionHeader(for: key))) {
                                ForEach(items) { item in
                                    HStack {
                                        Button(action: {
                                            viewModel.toggleCompletion(for: item)
                                        }) {
                                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                                .foregroundColor(item.isCompleted ? .green : .gray)
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                        
                                        Text(item.title)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .strikethrough(item.isCompleted)
                                        
                                        PriorityIndicatorView(priority: item.priority)

                                    }
                                    .padding(.vertical, Constants.Padding.medium)
                                }
                                .onDelete(perform: { indexSet in
                                    if let index = indexSet.first {
                                        viewModel.removeData(at: index)
                                    }
                                    viewModel.loadData()
                                })
                            }
                        }
                    }
                    .onAppear {
                        viewModel.loadData()
                    }
                }
            }
            .navigationTitle(viewModel.toDoItems.isEmpty ? "" : Constants.HomeView.navigationTitleDoIt)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Picker("", selection: $viewModel.groupingCriteria) {
                        Text(Constants.status).tag(GroupingCriteria.status)
                        Text(Constants.category).tag(GroupingCriteria.category)
                    }
                    .pickerStyle(.menu)
                }
            }
        } detail: {
            Text(Constants.HomeView.navigationTitleDetailforIpad)
        }
    }

    // MARK: - Priority Custom View
    struct PriorityIndicatorView: View {
        let priority: ToDoPriority
        
        var body: some View {
            switch priority {
            case .low:
                Image(systemName: "chevron.down.circle.fill")
                    .foregroundStyle(Color(.systemGreen))
            case .medium:
                Image(systemName: "arrow.up.arrow.down.circle.fill")
                    .foregroundStyle(Color(.systemYellow))
            case .high:
                Image(systemName: "chevron.up.circle.fill")
                    .foregroundStyle(Color(.systemRed))
            }
        }
    }
}
