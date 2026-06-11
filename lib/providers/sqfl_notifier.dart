import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/providers/app_state_provider.dart';
import 'package:i12_into_012/providers/providers.dart';

class SqflNotifier extends AppStateNotifier {
  @override
  AppState build() {
    _loadState();
    return AppState.initial();
  }

  Future<void> _loadState() async {
    try {
      final appState = await ref.read(databaseServiceProvider).loadAppState();
      if (state.todos.isEmpty) {
        state = appState;
      }

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
    _persistTodo(newTodo, isNew: true);
  }

  @override
  void toggleTodo(String id) {
    Todo? updatedTodo;

    state = state.copyWith(
      todos: state.todos.map((todo) {
        if (todo.id == id) {
          updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
          return updatedTodo!;
        }
        return todo;
      }).toList(),
    );

    if (updatedTodo != null) {
      _persistTodo(updatedTodo!, isNew: false);
    }
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

    final idsToDelete = Set<String>.from(state.selectedTodoIds);
    final remainingTodos = state.todos
        .where((todo) => !idsToDelete.contains(todo.id))
        .toList();

    state = state.copyWith(
      todos: remainingTodos,
      selectedTodoIds: {},
    );

    try {
      await ref.read(databaseServiceProvider).deleteTodos(idsToDelete);

      ///Wird ignoriert weil ich on clause nicht kenne
      // ignore: empty_catches, avoid_catches_without_on_clauses
    } catch (e) {}
  }

  @override
  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    _persistSettings();
  }

  Future<void> _persistTodo(Todo todo, {required bool isNew}) async {
    try {
      final db = ref.read(databaseServiceProvider);
      if (isNew) {
        await db.insertTodo(todo);
      } else {
        await db.updateTodo(todo);
      }

      ///Wird ignoriert weil ich on clause nicht kenne
      // ignore: empty_catches, avoid_catches_without_on_clauses
    } catch (e) {}
  }

  Future<void> _persistSettings() async {
    try {
      await ref
          .read(databaseServiceProvider)
          .saveSettings(
            isDarkMode: state.isDarkMode,
            asksForDeletionConfirmation: state.asksForDeletionConfirmation,
          );

      ///Wird ignoriert weil ich on clause nicht kenne
      // ignore: empty_catches, avoid_catches_without_on_clauses
    } catch (e) {}
  }
}
