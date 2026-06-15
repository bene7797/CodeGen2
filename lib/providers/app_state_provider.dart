import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:i12_into_012/models/app_state.dart';

import 'package:i12_into_012/providers/sqfl_notifier.dart';

final appStateProvider = NotifierProvider<AppStateNotifier, AppState>(() {
  return SqflNotifier();
});

/// Öffentliche API für UI und Storage-Implementierungen.
abstract class AppStateNotifier extends Notifier<AppState> {
  void addTodo(String text);

  void toggleTodo(String id);

  void toggleSelection(String id);

  void clearSelection();

  Future<void> deleteSelectedTodos();

  void toggleDarkMode();
}
