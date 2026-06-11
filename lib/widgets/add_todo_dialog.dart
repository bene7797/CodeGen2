import 'package:flutter/material.dart';

///Dialogfenster für das adden von Todos
class AddTodoDialog extends StatefulWidget {
  ///Erstellt Tododialoge objekt
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Todo hinzufügen'),

      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Todo eingeben...',
          border: OutlineInputBorder(),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Abbrechen'),
        ),

        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, controller.text);
          },
          child: const Text('Hinzufügen'),
        ),
      ],
    );
  }
}
