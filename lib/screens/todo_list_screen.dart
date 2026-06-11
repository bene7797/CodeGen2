import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/providers/app_state_provider.dart';
import 'package:i12_into_012/providers/providers.dart';
import 'package:i12_into_012/screens/settings_screen.dart';
import 'package:i12_into_012/widgets/add_todo_dialog.dart';
import 'package:i12_into_012/widgets/todo_item.dart';

///Todoscreen, wird beim start gezeigt und stellt alle -Todos optisch dar
class TodoScreen extends ConsumerStatefulWidget {
  ///Erstellt ein Todoscreen Objekt
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todosProvider);
    final selectedIds = ref.watch(selectedTodosProvider);
    final hasSelected = ref.watch(hasSelectedTodosProvider);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            hasSelected ? '${selectedIds.length} ausgewählt' : 'Todos',
          ),
        ),
        actions: [
          if (hasSelected)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref.read(appStateProvider.notifier).deleteSelectedTodos();
              },
            ),

          if (hasSelected)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                ref.read(appStateProvider.notifier).clearSelection();
              },
            ),

          if (!hasSelected)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<String>(
            context: context,
            builder: (context) => const AddTodoDialog(),
          );

          if (result != null && result.trim().isNotEmpty) {
            ref.read(appStateProvider.notifier).addTodo(result);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          ...todos.map(
            (todo) => TodoItem(
              text: todo.text,
              done: todo.isCompleted,
              id: todo.id,
            ),
          ),
        ],
      ),
    );
  }
}
