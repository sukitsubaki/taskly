import Foundation

/// Task data model representing a single todo item
struct Task: Identifiable, Codable, Equatable {
    /// Unique identifier for each task
    var id = UUID()
    
    /// Title or description of the task
    var title: String
    
    /// Indicates whether the task is completed
    var isCompleted: Bool = false
    
    /// Creation date of the task
    var createdDate = Date()
    
    /// Compare two tasks for equality
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
}
