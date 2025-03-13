import SwiftUI

// Main view for the Taskly app
struct ContentView: View {
    // ViewModel to manage tasks
    @StateObject private var viewModel = TaskViewModel()
    
    // State for the new task input
    @State private var newTaskTitle = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Task input section
                HStack {
                    // Text field for new task
                    TextField("Enter a new task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.sentences)
                    
                    // Add task button
                    Button(action: addTask) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .imageScale(.large)
                    }
                    .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding()
                
                // Tasks list
                List {
                    ForEach(viewModel.tasks) { task in
                        HStack {
                            // Task completion status indicator
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    viewModel.toggleTaskCompletion(task: task)
                                }
                            
                            // Task title
                            Text(task.title)
                                .strikethrough(task.isCompleted, color: .gray)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Taskly")
        }
    }
    
    // Function to add a new task
    private func addTask() {
        viewModel.addTask(title: newTaskTitle)
        newTaskTitle = ""
    }
}

// App entry point
@main
struct TasklyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
