import 'dart:io';

import 'package:i12_into_012/models/app_state.dart';
import 'package:i12_into_012/models/todo.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite-Speicher für Todos und App-Einstellungen.
class DatabaseService {
  Database? _database;

  Future<Database> get _db async {
    final existing = _database;
    if (existing != null) return existing;

    final db = await openDatabase(
      await _databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    _database = db;
    return db;
  }

  Future<String> get _databasePath async {
    if (Platform.isWindows || Platform.isLinux) {
      final directory = await getApplicationDocumentsDirectory();
      return join(directory.path, 'todo_app.db');
    }

    final directory = await getDatabasesPath();
    return join(directory, 'todo_app.db');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id TEXT PRIMARY KEY,
        text TEXT NOT NULL,
        is_completed INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE settings (
        id INTEGER PRIMARY KEY CHECK (id = 1),
        is_dark_mode INTEGER NOT NULL,
        asks_for_deletion_confirmation INTEGER NOT NULL
      )
    ''');
    await db.insert('settings', {
      'id': 1,
      'is_dark_mode': 0,
      'asks_for_deletion_confirmation': 1,
    });
  }

  Future<AppState> loadAppState() async {
    final db = await _db;
    final todoRows = await db.query('todos');
    final settingsRows = await db.query(
      'settings',
      where: 'id = ?',
      whereArgs: [1],
    );

    final todos = todoRows.map(_todoFromRow).toList();
    final settings = settingsRows.first;

    return AppState(
      todos: todos,
      isDarkMode: (settings['is_dark_mode'] as int) == 1,
      asksForDeletionConfirmation:
          (settings['asks_for_deletion_confirmation'] as int) == 1,
      selectedTodoIds: {},
    );
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await _db;
    await db.insert('todos', _todoToRow(todo));
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await _db;
    await db.update(
      'todos',
      _todoToRow(todo),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodos(Iterable<String> ids) async {
    final idList = ids.toList();
    if (idList.isEmpty) return;

    final db = await _db;
    final placeholders = List.filled(idList.length, '?').join(', ');
    await db.delete(
      'todos',
      where: 'id IN ($placeholders)',
      whereArgs: idList,
    );
  }

  Future<void> saveSettings({
    required bool isDarkMode,
    required bool asksForDeletionConfirmation,
  }) async {
    final db = await _db;
    await db.update(
      'settings',
      {
        'is_dark_mode': isDarkMode ? 1 : 0,
        'asks_for_deletion_confirmation':
            asksForDeletionConfirmation ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Todo _todoFromRow(Map<String, Object?> row) {
    return Todo(
      id: row['id']! as String,
      text: row['text']! as String,
      isCompleted: (row['is_completed'] as int) == 1,
    );
  }

  Map<String, Object?> _todoToRow(Todo todo) {
    return {
      'id': todo.id,
      'text': todo.text,
      'is_completed': todo.isCompleted ? 1 : 0,
    };
  }
}
