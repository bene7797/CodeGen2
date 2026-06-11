import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i12_into_012/providers/app_state_provider.dart';
import 'package:i12_into_012/providers/providers.dart';

///Seite für Einstellungen
class SettingsScreen extends ConsumerWidget {
  ///Erstellt ein Settingscreen Objekt
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SwitchListTile(
        title: const Text('Dark Mode'),
        subtitle: const Text('Dunkles Design aktivieren'),
        value: isDarkMode,
        onChanged: (value) {
          ref.read(appStateProvider.notifier).toggleDarkMode();
        },
      ),
    );
  }
}
