import SwiftUI

/// Main view for the Taskly app
struct ContentView: View {
    // ViewModel to manage tasks
    @StateObject private var viewModel = TaskViewModel()
    
    // State for showing the add task sheet
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Empty state
                if viewModel.tasks.isEmpty {
                    EmptyTaskView()
                } else {
                    // Tasks list
                    List {
                        ForEach(viewModel.filteredTasks) { task in
                            TaskRow(task: task) {
                                viewModel.toggleTaskCompletion(task: task)
                            }
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Taskly")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Toggle("Show Completed", isOn: $viewModel.showCompleted)
                        
                        if !viewModel.tasks.filter({ $0.isCompleted }).isEmpty {
                            Button(role: .destructive, action: viewModel.clearCompletedTasks) {
                                Label("Clear Completed", systemImage: "trash")
                            }
                        }
                    } label: {
                        Label("Options", systemImage: "slider.horizontal.3")
                    }
                    .disabled(viewModel.tasks.isEmpty)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
