import Foundation

// Model for a Task
struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }
    
    let tasksKey = "tasksKey"
    
    init() {
        loadTasks()
    }
    
    func addTask(title: String) {
        let newTask = Task(title: title, isCompleted: false)
        tasks.append(newTask)
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    private func loadTasks() {
        if let savedTasks = UserDefaults.standard.data(forKey: tasksKey),
           let decodedTasks = try? JSONDecoder().decode([Task].self, from: savedTasks) {
            tasks = decodedTasks
        }
    }
}
