import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/providers/app_state_provider.dart';
import 'package:i12_into_012/providers/providers.dart';

/// Einzelnes Todo-Item
/// Kann:
/// [text] - hallo
/// - durch tap als erledigt markiert werden
/// - durch langen tap ausgewählt werden
/// - sich an dark oder light mode anpassen
class TodoItem extends ConsumerWidget {
  /// Erstellt ein neues TodoItem.
  const TodoItem({
    required this.text,
    required this.done,
    required this.id,
    super.key,
  });

  /// Der im Todo dargestellte Text
  final String text;

  /// Speicher ob Todo erledigt ist oder nicht
  final bool done;

  /// Eindeutige ID für Todo
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIds = ref.watch(selectedTodosProvider);
    final isSelected = selectedIds.contains(id);

    final theme = Theme.of(context);

    var backgroundColor = theme
        .colorScheme
        .surfaceContainerHighest; //Farbe die sich an Mode anpasst
    var iconColor = theme.colorScheme.outline;
    var icon = Icons.circle_outlined;

    if (done) {
      icon = Icons.check_circle;
      iconColor = Colors.green;
    }

    if (isSelected) {
      backgroundColor = theme.colorScheme.primaryContainer;
      icon = Icons.check_box;
      iconColor = theme.colorScheme.primary;
    }

    return GestureDetector(
      onTap: () {
        if (selectedIds.isNotEmpty) {
          ref.read(appStateProvider.notifier).toggleSelection(id);
        } else {
          ref.read(appStateProvider.notifier).toggleTodo(id);
        }
      },
      onLongPress: () {
        ref.read(appStateProvider.notifier).toggleSelection(id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface,
                  decoration: done ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
