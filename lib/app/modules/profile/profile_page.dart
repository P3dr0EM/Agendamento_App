import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/profile/profile_controller.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';
import 'package:una_agendamento/constants.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: TextStyle(
            color: isDark ? preto : null,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () => Get.snackbar(
                    'Perfil',
                    'Você já está na página de perfil.',
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage(controller.avatarAsset.value),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  controller.userName.value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bem-vindo(a)!',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? corRoxaPrincipal : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Editar perfil'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Get.snackbar(
                    'Editar perfil',
                    'Funcionalidade em desenvolvimento.',
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: Text(
                    'Configurações'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Get.toNamed(Routes.SETTINGS),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.calendar_month_outlined),
                  title: const Text('Meus agendamentos'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Get.snackbar(
                    'Meus agendamentos',
                    'Funcionalidade em desenvolvimento.',
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Ver perfil'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Get.snackbar(
                    'Ver perfil',
                    'Você já está na página de perfil.',
                    snackPosition: SnackPosition.BOTTOM,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Itens',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...controller.agendamentos.map((e) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(e),
                      trailing: const Icon(Icons.open_in_new_outlined, size: 18),
                      onTap: () => Get.snackbar(
                        'Agendamento',
                        'Funcionalidade em desenvolvimento.',
                        snackPosition: SnackPosition.BOTTOM,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

