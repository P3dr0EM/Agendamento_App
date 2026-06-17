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
          // CABEÇALHO DO PERFIL
          Center(
            child: Column(
              children: [
                Obx(() => InkWell(
                  onTap: controller.changeAvatar,
                  borderRadius: BorderRadius.circular(100),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage(controller.avatarAsset.value),
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera_alt, size: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 12),
                Obx(() => Text(
                  controller.userName.value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )),
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
          
          // OPÇÕES DO PERFIL
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text('Editar perfil'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: controller.editProfile,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Configurações'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Get.toNamed(Routes.SETTINGS),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Sair da conta', style: TextStyle(color: Colors.red)),
                  onTap: controller.logout,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // LISTA DE AGENDAMENTOS (Com reatividade de Loading)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Meus Agendamentos',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, size: 20),
                        onPressed: controller.fetchAgendamentos,
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Envolvendo a lista em um Obx para escutar o estado de carregamento
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    
                    if (controller.agendamentos.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Nenhum agendamento encontrado.'),
                      );
                    }

                    return Column(
                      children: controller.agendamentos.map((agendamento) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(agendamento),
                          trailing: const Icon(Icons.open_in_new_outlined, size: 18),
                          onTap: () => controller.openAgendamentoDetails(agendamento),
                        );
                      }).toList(),
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