// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppState _$AppStateFromJson(Map<String, dynamic> json) => _AppState(
  todos: (json['todos'] as List<dynamic>)
      .map((e) => Todo.fromJson(e as Map<String, dynamic>))
      .toList(),
  isDarkMode: json['isDarkMode'] as bool,
  asksForDeletionConfirmation: json['asksForDeletionConfirmation'] as bool,
  selectedTodoIds: (json['selectedTodoIds'] as List<dynamic>)
      .map((e) => e as String)
      .toSet(),
);

Map<String, dynamic> _$AppStateToJson(_AppState instance) => <String, dynamic>{
  'todos': instance.todos,
  'isDarkMode': instance.isDarkMode,
  'asksForDeletionConfirmation': instance.asksForDeletionConfirmation,
  'selectedTodoIds': instance.selectedTodoIds.toList(),
};
