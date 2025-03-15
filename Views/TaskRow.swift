import SwiftUI

/// Custom view for a single task row
struct TaskRow: View {
    // Task to display
    var task: Task
    
    // Callback for when the completion status changes
    var toggleCompletion: () -> Void
    
    var body: some View {
        HStack {
            // Task completion status indicator
            Button(action: toggleCompletion) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .imageScale(.large)
                    .animation(.easeInOut, value: task.isCompleted)
            }
            .buttonStyle(BorderlessButtonStyle())
            
            // Task title
            Text(task.title)
                .font(.body)
                .strikethrough(task.isCompleted, color: .gray)
                .foregroundColor(task.isCompleted ? .gray : .primary)
                .animation(.easeInOut, value: task.isCompleted)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

#Preview {
    TaskRow(task: Task(title: "Complete the app", isCompleted: false), toggleCompletion: {})
        .previewLayout(.sizeThatFits)
        .padding()
}
