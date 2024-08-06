//
//  ProfileView.swift
//  Things To Do
//
//  Created by Feyyaz ONUR on 6.08.2024.
//

import SwiftUI
import Charts

struct ProfileView: View {
    let toDoItems: [ToDoItem]

    private var totalItems: Int {
        toDoItems.count
    }

    private var statusDistribution: [(status: String, count: Int)] {
        let statusCounts = Dictionary(grouping: toDoItems, by: { $0.status })
            .mapValues { $0.count }

        return statusCounts.map { (status: "\($0.key)", count: $0.value) }
    }

    private var priorityDistribution: [(priority: String, count: Int)] {
        let priorityCounts = Dictionary(grouping: toDoItems, by: { $0.priority })
            .mapValues { $0.count }

        return priorityCounts.map { (priority: "\($0.key)", count: $0.value) }
    }

    private var completionPercentage: Double {
        let completedItems = toDoItems.filter { $0.status == .done }.count
        return totalItems == 0 ? 0.0 : Double(completedItems) / Double(totalItems) * 100
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(Constants.Tabbar.profileView)
                    .font(.largeTitle)
                    .bold()

                Text("\(Constants.ProfileView.totalTask)\(totalItems)")
                    .font(.headline)

                VStack(alignment: .leading) {
                    Text(Constants.ProfileView.completionPercentage)
                        .font(.headline)
                    ProgressView(value: completionPercentage, total: 100)
                        .progressViewStyle(LinearProgressViewStyle())
                        .padding(.vertical)
                    Text(String(format: "%.2f%%", completionPercentage))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                VStack(alignment: .leading) {
                    Text(Constants.ProfileView.taskStatusDistribution)
                        .font(.headline)
                    Chart(statusDistribution, id: \.status) { dataPoint in
                        SectorMark(
                            angle: .value(Constants.ProfileView.status, dataPoint.count),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .cornerRadius(5)
                        .opacity(dataPoint.status == statusDistribution.max(by: { $0.count < $1.count })?.status ? 1 : 0.5)
                    }
                    .frame(height: 200)
                }

                VStack(alignment: .leading) {
                    Text(Constants.ProfileView.taskPriorityDistribution)
                        .font(.headline)
                    Chart(priorityDistribution, id: \.priority) { dataPoint in
                        BarMark(
                            x: .value(Constants.ProfileView.priority, dataPoint.priority),
                            y: .value(Constants.ProfileView.count, dataPoint.count)
                        )
                        .foregroundStyle(by: .value(Constants.ProfileView.priority, dataPoint.priority))
                        .annotation(position: .trailing) {
                            Text(String(dataPoint.count))
                                .foregroundColor(.gray)
                        }
                    }
                    .chartLegend(.hidden)
                    .chartXAxis {
                        AxisMarks(values: .automatic)
                    }
                    .chartYAxis {
                        AxisMarks(values: .automatic)
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .padding()
                }
            }
            .padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleItems = [
            ToDoItem(title: "Task 1", description: "Description 1", priority: .low, status: .todo),
            ToDoItem(title: "Task 2", description: "Description 2", priority: .medium, status: .doing),
            ToDoItem(title: "Task 3", description: "Description 3", priority: .high, status: .done),
            ToDoItem(title: "Task 4", description: "Description 4", priority: .low, status: .done)
        ]
        ProfileView(toDoItems: sampleItems)
    }
}
