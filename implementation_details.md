# Todo App Implementation Details

This document provides detailed implementation guidance for the minimal Todo app, including code snippets for key components.

## Model Classes

### Todo Model

```dart
class Todo {
  final String id;
  final String text;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  // Create a copy with modified properties
  Todo copyWith({
    String? id,
    String? text,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isCompleted': isCompleted,
    };
  }

  // Create Todo from JSON
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      text: json['text'],
      isCompleted: json['isCompleted'],
    );
  }
}
```

### AppState Model

```dart
class AppState {
  final List<Todo> todos;
  final bool isDarkMode;
  final bool asksForDeletionConfirmation;
  final Set<String> selectedTodoIds; // For tracking selected items

  AppState({
    this.todos = const [],
    this.isDarkMode = false,
    this.asksForDeletionConfirmation = true,
    this.selectedTodoIds = const {},
  });

  // Create a copy with modified properties
  AppState copyWith({
    List<Todo>? todos,
    bool? isDarkMode,
    bool? asksForDeletionConfirmation,
    Set<String>? selectedTodoIds,
  }) {
    return AppState(
      todos: todos ?? this.todos,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      asksForDeletionConfirmation: asksForDeletionConfirmation ?? this.asksForDeletionConfirmation,
      selectedTodoIds: selectedTodoIds ?? this.selectedTodoIds,
    );
  }

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'todos': todos.map((todo) => todo.toJson()).toList(),
      'isDarkMode': isDarkMode,
      'asksForDeletionConfirmation': asksForDeletionConfirmation,
      // We don't persist selection state
    };
  }

  // Create AppState from JSON
  factory AppState.fromJson(Map<String, dynamic> json) {
    return AppState(
      todos: (json['todos'] as List)
          .map((todoJson) => Todo.fromJson(todoJson))
          .toList(),
      isDarkMode: json['isDarkMode'] ?? false,
      asksForDeletionConfirmation: json['asksForDeletionConfirmation'] ?? true,
    );
  }
}
```

## State Management

### AppStateNotifier

```dart
class AppStateNotifier extends StateNotifier<AppState> {
  final StorageService _storageService;
  
  AppStateNotifier(this._storageService) : super(AppState()) {
    loadState();
  }

  // Load state from storage
  Future<void> loadState() async {
    try {
      final appState = await _storageService.loadAppState();
      if (appState != null) {
        state = appState;
      }
    } catch (e) {
      // Handle error or use default state
      print('Error loading state: $e');
    }
  }

  // Save state to storage
  Future<void> saveState() async {
    try {
      await _storageService.saveAppState(state);
    } catch (e) {
      print('Error saving state: $e');
    }
  }

  // Add a new todo
  void addTodo(String text) {
    if (text.trim().isEmpty) return;
    
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
    );
    
    state = state.copyWith(
      todos: [...state.todos, newTodo],
    );
    
    saveState();
  }

  // Toggle todo completion status
  void toggleTodo(String id) {
    state = state.copyWith(
      todos: state.todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(isCompleted: !todo.isCompleted);
        }
        return todo;
      }).toList(),
    );
    
    saveState();
  }

  // Toggle todo selection
  void toggleSelection(String id) {
    final selectedIds = Set<String>.from(state.selectedTodoIds);
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    
    state = state.copyWith(selectedTodoIds: selectedIds);
  }

  // Clear all selections
  void clearSelection() {
    state = state.copyWith(selectedTodoIds: {});
  }

  // Delete selected todos
  Future<void> deleteSelectedTodos() async {
    if (state.selectedTodoIds.isEmpty) return;
    
    final remainingTodos = state.todos.where(
      (todo) => !state.selectedTodoIds.contains(todo.id)
    ).toList();
    
    state = state.copyWith(
      todos: remainingTodos,
      selectedTodoIds: {},
    );
    
    saveState();
  }

  // Toggle dark mode
  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    saveState();
  }

  // Toggle deletion confirmation
  void toggleDeletionConfirmation() {
    state = state.copyWith(
      asksForDeletionConfirmation: !state.asksForDeletionConfirmation
    );
    saveState();
  }
}
```

## Storage Service

```dart
class StorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todo_app_state.json');
  }

  Future<void> saveAppState(AppState state) async {
    final file = await _localFile;
    final jsonString = jsonEncode(state.toJson());
    await file.writeAsString(jsonString);
  }

  Future<AppState?> loadAppState() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return null;
      }
      
      final jsonString = await file.readAsString();
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppState.fromJson(jsonMap);
    } catch (e) {
      print('Error loading app state: $e');
      return null;
    }
  }
}
```

## Providers

```dart
// Storage service provider
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

// App state notifier provider
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return AppStateNotifier(storageService);
});

// Derived providers for convenience
final todosProvider = Provider<List<Todo>>((ref) {
  return ref.watch(appStateProvider).todos;
});

final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(appStateProvider).isDarkMode;
});

final selectedTodosProvider = Provider<Set<String>>((ref) {
  return ref.watch(appStateProvider).selectedTodoIds;
});

final hasSelectedTodosProvider = Provider<bool>((ref) {
  return ref.watch(selectedTodosProvider).isNotEmpty;
});
```