import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:i12_into_012/providers/app_state_provider.dart';
import 'package:i12_into_012/providers/providers.dart';

class SqflNotifier extends AppStateNotifier {
  var _isLoading = true;

  @override
  AppState build() {
    _loadState();
    return AppState.initial();
  }

  Future<void> _loadState() async {
    try {
      final appState = await ref.read(databaseServiceProvider).loadAppState();
      if (_isLoading) {
        state = appState;
      }
    } catch (e) {
      // Fehler beim Laden: Startzustand beibehalten
    } finally {
      _isLoading = false;
    }
  }

  @override
  void addTodo(String text) {
    if (text.trim().isEmpty) return;

    _isLoading = false;

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
    } catch (e) {
      // Fehler beim Löschen: UI-Zustand bleibt, DB evtl. inkonsistent
    }
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
    } catch (e) {
      // Fehler beim Speichern
    }
  }

  Future<void> _persistSettings() async {
    try {
      await ref.read(databaseServiceProvider).saveSettings(
            isDarkMode: state.isDarkMode,
            asksForDeletionConfirmation: state.asksForDeletionConfirmation,
          );
    } catch (e) {
      // Fehler beim Speichern
    }
  }
}
