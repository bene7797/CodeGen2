# Minimal Todo App Architecture Plan

## Overview
This document outlines the architecture for a minimal Todo app built with Flutter and Riverpod for educational purposes. The app will feature a simple Todo list with add, toggle, and delete functionality, along with basic settings for dark mode and deletion confirmation.

## Proposed File Structure
```
lib/
├── main.dart                  # App entry point
├── models/
│   ├── todo.dart              # Todo model with serialization
│   └── app_state.dart         # AppState model with serialization
├── providers/
│   └── app_state_provider.dart # Riverpod state management
├── services/
│   └── storage_service.dart   # File persistence service
├── screens/
│   ├── todo_list_screen.dart  # Main Todo list screen
│   └── settings_screen.dart   # Settings screen
└── widgets/
    ├── todo_item.dart         # Individual Todo item widget
    └── add_todo_dialog.dart   # Dialog for adding new Todos
```

## Key Components

### Models

#### Todo
- Properties:
  - `id (int)`: Unique identifier (randomly generated UUID)
  - `text (String)`: Todo content
  - `isCompleted (bool)`: Completion status
- Methods:
  - `toJson()`: Convert to JSON for storage (returns `Map<String, dynamic>`)
  - `fromJson()`: Create Todo from JSON (factory constructor)
  - `copyWith()`: Create a copy with modified properties (returns `Todo`)

- Make it immutable.
- Use uuid package (already added) to generate unique IDs.
- Do not forget to implement equality and hashCode.

#### AppState
- Properties:
  - `todos (List<Todo>)`: List of todo items
  - `isDarkMode (bool)`: Theme setting
  - `asksForDeletionConfirmation (bool)`: Deletion confirmation setting
- Methods:
  - `toJson()`: Convert to JSON for storage (returns `Map<String, dynamic>`)
  - `fromJson()`: Create AppState from JSON (factory constructor)
  - `copyWith()`: Create a copy with modified properties (returns `AppState`)

- Make it immutable.
- Do not forget to implement equality and hashCode.

### State Management

#### Provider declarations (excerpt):

```dart
// App state notifier provider
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
```

#### AppStateNotifier
- Extends `Notifier<AppState>`
- Methods:
  - `addTodo(String text)`: Add new Todo
  - `toggleTodo(ToDo toDo)`: Toggle completion status
  - `deleteTodos(List<ToDo> toDos)`: Delete selected Todos
  - `toggleDarkMode()`: Switch theme
  - `toggleDeletionConfirmation()`: Toggle confirmation setting
  - `loadState()`: Load state from storage
  - `saveState()`: Save state to storage

- Always use `copyWith` to update state immutably.

##### Example Implementation (excerpt):

```dart
class AppStateNotifier extends Notifier<AppState> {
  final _storageService = StorageService();
  final _uuid = Uuid();

  AppStateNotifier() {
    // Load initial state after initialization
    loadState();
  }

  AppState build() {
    // Initialize with default state
    return AppState(
      todos: [],
      isDarkMode: false,
      asksForDeletionConfirmation: true,
    );
  }

  // Add a new todo
  void addTodo(String text) {
    if (text.trim().isEmpty) return;
    final newTodo = Todo(
      id: _uuid.v4(),
      text: text.trim(),
    );
    // Update state immutably
    state = state.copyWith(
      todos: [...state.todos, newTodo],
    );
    // Save updated state
    saveState();
  }
```

### Services

#### StorageService
- Methods:
  - `saveAppState(AppState state)`: Save state to file
  - `loadAppState()`: Load state from file (returns `AppState?`)

### Screens

#### TodoListScreen
- Features:
  - Display list of Todos
  - FAB for adding new Todos
  - Some solution for deleting Todos (e.g., long-press to select and delete button)
  - Settings button in app bar
  - Some solution for editing Todos (optional)
- Do use a key for each TodoItem widget (you can use the Todo id).

#### SettingsScreen
- Features:
  - Toggle for dark mode
  - Toggle for deletion confirmation
- StatefulWidget if necessary for your deletion solution, otherwise StatelessWidget.

### Widgets

#### TodoItem
- Features:
  - Displays one list entry representing a Todo
  - Checkbox for completion status
  - Probably implements the deletion solution (e.g., long-press to select)

#### AddTodoDialog
- Features:
  - Text input for new Todo
  - Submit button
  - Cancel button

## Data Flow

1. **App Initialization**:
  - Load AppState from storage
  - Initialize AppStateNotifier with loaded state
  - Provide state to app via ProviderScope

2. **Adding a Todo**:
  - User taps FAB
  - AddTodoDialog appears
  - User enters text and submits
  - AppStateNotifier adds Todo to state
  - State is saved to storage

4. **Deleting Todos**:
  - Your own solution for selecting Todos to delete
  - User confirms deletion (if setting enabled)
  - AppStateNotifier removes selected Todos
  - State is saved to storage

5. **Changing Settings**:
  - User navigates to Settings screen
  - User toggles settings
  - AppStateNotifier updates settings
  - State is saved to storage

## Persistence
- AppState is serialized to JSON
- JSON is saved to a file via FileStorageService using path_provider
- On app start (or provider initialization), state is loaded from file
- If no file exists, default state is used

## Theme Management
- MaterialApp uses theme based on isDarkMode setting
- Theme changes are applied immediately when toggled

## GUI Layout Specifications

### TodoListScreen Layout
```
┌─────────────────────────────────────┐
│ AppBar                         O    │ <- Settings-Icon
├─────────────────────────────────────┤
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ O Buy groceries                 │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ O Call mom                      │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ O Finish project                │ │
│ └─────────────────────────────────┘ │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                              ****   │
|                             *    *  |
|                             *    *  | <- Plus-Button
|                              ****   |
|                                     │
└─────────────────────────────────────┘
```

### Add Todo Dialog
```
┌─────────────────────────────────────┐
│                                     │
│             Add New Todo            │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Enter todo text...              │ │
│ └─────────────────────────────────┘ │
│                                     │
│                Cancel     Add       │
│                                     │
└─────────────────────────────────────┘
```

### Delete Confirmation Dialog
```
┌─────────────────────────────────────┐
│                                     │
│           Confirm Deletion          │
│                                     │
│  Are you sure you want to delete    │
│  the selected items?                │
│                                     │
│                                     │
│                Cancel     Delete    │
│                                     │
└─────────────────────────────────────┘
```

### Settings Screen Layout
```
┌─────────────────────────────────────┐
│ ← Settings                          │
├─────────────────────────────────────┤
│                                     │
│  Dark Mode                      O   │
│                                     │
│  Ask for Deletion Confirmation  O   │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
│                                     │
└─────────────────────────────────────┘
```

### Image Generation Prompts

If you need to generate actual images of these layouts, you can use the following prompts with other AI image generators:

1. **Todo List Screen**: "Create a minimalist mobile app UI for a todo list application. The screen shows a list of todo items with checkboxes, a settings gear icon in the top right corner, and a floating action button with a plus sign at the bottom center. Use Material Design styling."

2. **Selection Mode**: "Design a mobile UI showing a todo list in selection mode. Multiple items are selected with checkmarks on the right side, the app bar shows the number of selected items and a trash icon for deletion. Use Material Design styling."

3. **Add Todo Dialog**: "Create a simple dialog box for adding a new todo item. The dialog has a text input field and two buttons: 'Cancel' and 'Add'. Use Material Design styling."

4. **Settings Screen**: "Design a minimal settings screen for a todo app with two toggle switches: one for 'Dark Mode' and another for 'Ask for Deletion Confirmation'. Include a back arrow in the app bar. Use Material Design styling."