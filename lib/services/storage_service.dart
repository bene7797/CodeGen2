// ignore_for_file: document_ignores

import 'dart:convert';
import 'dart:io';

import 'package:i12_into_012/models/app_state.dart';
import 'package:path_provider/path_provider.dart';

///Klasse für Speicherverwaltung
class StorageService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todo_app_state.json');
  }

  ///Speichert den Zusatnd der app
  Future<void> saveAppState(AppState state) async {
    final file = await _localFile;
    final jsonString = jsonEncode(state.toJson());
    await file.writeAsString(jsonString);
  }

  ///Lädt den zustand der app
  Future<AppState?> loadAppState() async {
    try {
      final file = await _localFile;
      // ignore: duplicate_ignore
      // ignore: document_ignores
      // ignore: avoid_slow_async_io
      if (!await file.exists()) {
        return null;
      }

      final jsonString = await file.readAsString();
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return AppState.fromJson(jsonMap);

      ///ignorieren ich weil ich on clause nicht kenne
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return null;
    }
  }
}
