import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/providers/app_state_provider.dart';
import 'package:i12_into_012/providers/providers.dart';

class LocalJsonNotifier extends AppStateNotifier {
  @override
  AppState build() {
    _loadState();
    return AppState.initial();
  }

  Future<void> _loadState() async {
    try {
      final appState =
          await ref.read(storageServiceProvider).loadAppState();
      if (appState != null && state.todos.isEmpty) {
        state = appState;
      }

      ///Wird ignoriert weil ich on clause nicht kenne
      // ignore: empty_catches, avoid_catches_without_on_clauses
    } catch (e) {}
  }

  Future<void> _saveState() async {
    try {
      await ref.read(storageServiceProvider).saveAppState(state);

      ///Wird ignoriert weil ich on clause nicht kenne
      // ignore: empty_catches, avoid_catches_without_on_clauses
    } catch (e) {}
  }

  @override
  void addTodo(String text) {
    if (text.trim().isEmpty) return;

    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      isCompleted: false,
    );

    state = state.copyWith(todos: [...state.todos, newTodo]);
    _saveState();
  }

  @override
  void toggleTodo(String id) {
    state = state.copyWith(
      todos: state.todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(isCompleted: !todo.isCompleted);
        }
        return todo;
      }).toList(),
    );
    _saveState();
  }

  @override
  void toggleSelection(String id) {
    final selectedIds = Set<String>.from(state.selectedTodoIds);
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }

    state = state.copyWith(selectedTodoIds: selectedIds);
  }

  @override
  void clearSelection() {
    state = state.copyWith(selectedTodoIds: {});
  }

  @override
  Future<void> deleteSelectedTodos() async {
    if (state.selectedTodoIds.isEmpty) return;

    final remainingTodos = state.todos
        .where((todo) => !state.selectedTodoIds.contains(todo.id))
        .toList();

    state = state.copyWith(
      todos: remainingTodos,
      selectedTodoIds: {},
    );

    await _saveState();
  }

  @override
  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    _saveState();
  }
}
