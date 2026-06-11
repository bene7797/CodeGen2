// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppState {

 List<Todo> get todos; bool get isDarkMode; bool get asksForDeletionConfirmation; Set<String> get selectedTodoIds;
/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStateCopyWith<AppState> get copyWith => _$AppStateCopyWithImpl<AppState>(this as AppState, _$identity);

  /// Serializes this AppState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppState&&const DeepCollectionEquality().equals(other.todos, todos)&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode)&&(identical(other.asksForDeletionConfirmation, asksForDeletionConfirmation) || other.asksForDeletionConfirmation == asksForDeletionConfirmation)&&const DeepCollectionEquality().equals(other.selectedTodoIds, selectedTodoIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(todos),isDarkMode,asksForDeletionConfirmation,const DeepCollectionEquality().hash(selectedTodoIds));

@override
String toString() {
  return 'AppState(todos: $todos, isDarkMode: $isDarkMode, asksForDeletionConfirmation: $asksForDeletionConfirmation, selectedTodoIds: $selectedTodoIds)';
}


}

/// @nodoc
abstract mixin class $AppStateCopyWith<$Res>  {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) _then) = _$AppStateCopyWithImpl;
@useResult
$Res call({
 List<Todo> todos, bool isDarkMode, bool asksForDeletionConfirmation, Set<String> selectedTodoIds
});




}
/// @nodoc
class _$AppStateCopyWithImpl<$Res>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._self, this._then);

  final AppState _self;
  final $Res Function(AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todos = null,Object? isDarkMode = null,Object? asksForDeletionConfirmation = null,Object? selectedTodoIds = null,}) {
  return _then(_self.copyWith(
todos: null == todos ? _self.todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,isDarkMode: null == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool,asksForDeletionConfirmation: null == asksForDeletionConfirmation ? _self.asksForDeletionConfirmation : asksForDeletionConfirmation // ignore: cast_nullable_to_non_nullable
as bool,selectedTodoIds: null == selectedTodoIds ? _self.selectedTodoIds : selectedTodoIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppState].
extension AppStatePatterns on AppState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppState value)  $default,){
final _that = this;
switch (_that) {
case _AppState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppState value)?  $default,){
final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Todo> todos,  bool isDarkMode,  bool asksForDeletionConfirmation,  Set<String> selectedTodoIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.todos,_that.isDarkMode,_that.asksForDeletionConfirmation,_that.selectedTodoIds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Todo> todos,  bool isDarkMode,  bool asksForDeletionConfirmation,  Set<String> selectedTodoIds)  $default,) {final _that = this;
switch (_that) {
case _AppState():
return $default(_that.todos,_that.isDarkMode,_that.asksForDeletionConfirmation,_that.selectedTodoIds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Todo> todos,  bool isDarkMode,  bool asksForDeletionConfirmation,  Set<String> selectedTodoIds)?  $default,) {final _that = this;
switch (_that) {
case _AppState() when $default != null:
return $default(_that.todos,_that.isDarkMode,_that.asksForDeletionConfirmation,_that.selectedTodoIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppState implements AppState {
  const _AppState({required final  List<Todo> todos, required this.isDarkMode, required this.asksForDeletionConfirmation, required final  Set<String> selectedTodoIds}): _todos = todos,_selectedTodoIds = selectedTodoIds;
  factory _AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);

 final  List<Todo> _todos;
@override List<Todo> get todos {
  if (_todos is EqualUnmodifiableListView) return _todos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todos);
}

@override final  bool isDarkMode;
@override final  bool asksForDeletionConfirmation;
 final  Set<String> _selectedTodoIds;
@override Set<String> get selectedTodoIds {
  if (_selectedTodoIds is EqualUnmodifiableSetView) return _selectedTodoIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedTodoIds);
}


/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppStateCopyWith<_AppState> get copyWith => __$AppStateCopyWithImpl<_AppState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppState&&const DeepCollectionEquality().equals(other._todos, _todos)&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode)&&(identical(other.asksForDeletionConfirmation, asksForDeletionConfirmation) || other.asksForDeletionConfirmation == asksForDeletionConfirmation)&&const DeepCollectionEquality().equals(other._selectedTodoIds, _selectedTodoIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_todos),isDarkMode,asksForDeletionConfirmation,const DeepCollectionEquality().hash(_selectedTodoIds));

@override
String toString() {
  return 'AppState(todos: $todos, isDarkMode: $isDarkMode, asksForDeletionConfirmation: $asksForDeletionConfirmation, selectedTodoIds: $selectedTodoIds)';
}


}

/// @nodoc
abstract mixin class _$AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$AppStateCopyWith(_AppState value, $Res Function(_AppState) _then) = __$AppStateCopyWithImpl;
@override @useResult
$Res call({
 List<Todo> todos, bool isDarkMode, bool asksForDeletionConfirmation, Set<String> selectedTodoIds
});




}
/// @nodoc
class __$AppStateCopyWithImpl<$Res>
    implements _$AppStateCopyWith<$Res> {
  __$AppStateCopyWithImpl(this._self, this._then);

  final _AppState _self;
  final $Res Function(_AppState) _then;

/// Create a copy of AppState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todos = null,Object? isDarkMode = null,Object? asksForDeletionConfirmation = null,Object? selectedTodoIds = null,}) {
  return _then(_AppState(
todos: null == todos ? _self._todos : todos // ignore: cast_nullable_to_non_nullable
as List<Todo>,isDarkMode: null == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool,asksForDeletionConfirmation: null == asksForDeletionConfirmation ? _self.asksForDeletionConfirmation : asksForDeletionConfirmation // ignore: cast_nullable_to_non_nullable
as bool,selectedTodoIds: null == selectedTodoIds ? _self._selectedTodoIds : selectedTodoIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
