import Foundation
import SwiftUI
import Combine

/// ViewModel to manage tasks and handle business logic
class TaskViewModel: ObservableObject {
    /// List of tasks that updates the UI when changed
    @Published var tasks: [Task] = [] {
        didSet {
            // Save tasks whenever the list is modified
            saveTasks()
        }
    }
    
    /// Flag to show or hide completed tasks
    @Published var showCompleted = true
    
    /// Computed property to get filtered tasks based on completion status
    var filteredTasks: [Task] {
        if showCompleted {
            return tasks.sorted(by: { !$0.isCompleted && $1.isCompleted })
        } else {
            return tasks.filter { !$0.isCompleted }
        }
    }
    
    /// Key for storing tasks in UserDefaults
    private let tasksKey = "tasklyTasksKey"
    
    /// Initialize the ViewModel by loading existing tasks
    init() {
        loadTasks()
    }
    
    /// Add a new task to the list
    /// - Parameter title: The title of the new task
    func addTask(title: String) {
        // Trim whitespace and ignore empty tasks
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }
        
        let newTask = Task(title: trimmedTitle)
        tasks.append(newTask)
    }
    
    /// Remove a task at specified index
    /// - Parameter offsets: IndexSet of tasks to remove
    func deleteTask(at offsets: IndexSet) {
        // Map offsets to indices in the unfiltered tasks array if filtering is applied
        let tasksToDelete = offsets.map { filteredTasks[$0] }
        tasks.removeAll { task in
            tasksToDelete.contains { $0.id == task.id }
        }
    }
    
    /// Toggle completion status of a task
    /// - Parameter task: The task to toggle
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    /// Clear all completed tasks
    func clearCompletedTasks() {
        tasks.removeAll { $0.isCompleted }
    }
    
    /// Save tasks to UserDefaults
    private func saveTasks() {
        do {
            let encodedData = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(encodedData, forKey: tasksKey)
        } catch {
            print("Error saving tasks: \(error)")
        }
    }
    
    /// Load tasks from UserDefaults
    private func loadTasks() {
        guard let savedData = UserDefaults.standard.data(forKey: tasksKey) else { return }
        
        do {
            tasks = try JSONDecoder().decode([Task].self, from: savedData)
        } catch {
            print("Error loading tasks: \(error)")
            tasks = []
        }
    }
}
