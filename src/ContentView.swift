import SwiftUI

// Main View
struct ContentView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("New Task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: addTask) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                }
                .padding()
                
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    viewModel.toggleTaskCompletion(task: task)
                                }
                            Text(task.title)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
            .navigationTitle("Taskly")
        }
    }
    
    func addTask() {
        guard !newTaskTitle.isEmpty else { return }
        viewModel.addTask(title: newTaskTitle)
        newTaskTitle = ""
    }
}

@main
struct TasklyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
