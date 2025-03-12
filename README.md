# Taskly - To-Do List App

Taskly is a simple To-Do List app built using SwiftUI, allowing users to manage tasks, mark them as completed and delete them. The app uses `UserDefaults` to persist the tasks across app launches.

## Features

- Add new tasks
- Mark tasks as completed/incomplete
- Delete tasks
- Data is saved using `UserDefaults`, so tasks persist even when the app is closed and reopened.

## Installation

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/your-username/taskly.git
   ```
2. Open the project in Xcode:
   ```bash
   open Taskly.xcodeproj
   ```
4. Build and run the app in the iOS simulator or on a physical device.

## Usage
1. Open the app.
2. Type a task name into the "New Task" text field.
3. Tap the "+" button to add the task to your list.
4. Tap on the circle next to a task to mark it as completed (green checkmark).
5. Swipe left on a task to delete it from the list.

## Code Explanation
- Model: `Task` represents a task with a title and a boolean to track whether it's completed.
- ViewModel: `TaskViewModel` manages the list of tasks. It handles adding, deleting, and toggling the completion status of tasks. The list is saved and loaded from `UserDefaults`.
- View: The `ContentView` is the main UI for adding and managing tasks. It uses SwiftUI components like `TextField`, `Button`, and `List` to display and interact with the tasks.
