import Foundation
import SwiftUI

// Task data model representing a single todo item
struct Task: Identifiable, Codable {
    // Unique identifier for each task
    var id = UUID()
    
    // Title or description of the task
    var title: String
    
    // Indicates whether the task is completed
    var isCompleted: Bool = false
}

// ViewModel to manage tasks and handle business logic
class TaskViewModel: ObservableObject {
    // List of tasks that updates the UI when changed
    @Published var tasks: [Task] = [] {
        didSet {
            // Save tasks whenever the list is modified
            saveTasks()
        }
    }
    
    // Key for storing tasks in UserDefaults
    private let tasksKey = "tasklyTasksKey"
    
    // Initialize the ViewModel by loading existing tasks
    init() {
        loadTasks()
    }
    
    // Add a new task to the list
    func addTask(title: String) {
        // Trim whitespace and ignore empty tasks
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }
        
        let newTask = Task(title: trimmedTitle)
        tasks.append(newTask)
    }
    
    // Remove a task at specified index
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // Toggle completion status of a task
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    // Save tasks to UserDefaults
    private func saveTasks() {
        do {
            let encodedData = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(encodedData, forKey: tasksKey)
        } catch {
            print("Error saving tasks: \(error)")
        }
    }
    
    // Load tasks from UserDefaults
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
