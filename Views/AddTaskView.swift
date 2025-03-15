import SwiftUI

/// Sheet view for adding a new task
struct AddTaskView: View {
    // Environment to dismiss the view
    @Environment(\.dismiss) private var dismiss
    
    // Reference to the task view model
    @ObservedObject var viewModel: TaskViewModel
    
    // State for the new task title
    @State private var newTaskTitle = ""
    
    // Focus state for the text field
    @FocusState private var isTitleFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("What needs to be done?", text: $newTaskTitle)
                        .focused($isTitleFocused)
                }
                
                Section {
                    Button(action: addTask) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Task")
                        }
                    }
                    .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                isTitleFocused = true
            }
        }
    }
    
    private func addTask() {
        viewModel.addTask(title: newTaskTitle)
        dismiss()
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModel())
}
