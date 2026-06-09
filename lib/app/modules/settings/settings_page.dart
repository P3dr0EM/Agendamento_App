import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/settings/settings_controller.dart';
import 'package:una_agendamento/constants.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configurações',
          style: TextStyle(
            color: isDark ? preto : null,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Obx(() {
            return SwitchListTile(
              title: const Text('Modo noturno'),
              subtitle: Text(
                controller.isDark.value ? 'Ativado' : 'Desativado',
              ),
              value: controller.isDark.value,
              onChanged: (_) {
                controller.toggleNightMode();
                // debug
                debugPrint('SettingsPage: toggleNightMode called. isDark=${controller.isDark.value}');
              },
            );
          }),
        ],
      ),
    );
  }
}

