import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:una_agendamento/constants.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ListView garante que o menu seja rolável se houver muitos itens.
      child: ListView(
        // Remove qualquer preenchimento da ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Um cabeçalho bonito e padrão para o Drawer.
          const UserAccountsDrawerHeader(
            accountName: Text("Nome do Usuário"),
            accountEmail: Text("usuario@email.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "U",
                style: TextStyle(fontSize: 40.0, color: Colors.blue),
              ),
            ),
            decoration: BoxDecoration(
              color: corRoxaPrincipal,
            ),
          ),
          // Item de menu "Início"
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () {
              Scaffold.of(context).closeDrawer();
            },
          ),
          // Item de menu "Configurações"
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Get.back();
              Get.toNamed('/settings');
            },
          ),

          const Divider(), // Uma linha divisória visual
          // Item de menu "Sair"
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () async {
              Get.back();
              try {
                // Sign out do Firebase
                await FirebaseAuth.instance.signOut();
                // Sign out do Google
                await GoogleSignIn().signOut();
                // Navegar para login
                Get.offAllNamed(Routes.LOGIN);
              } catch (e) {
                debugPrint('Erro ao fazer logout: $e');
                Get.snackbar('Erro', 'Falha ao fazer logout');
              }
            },
          ),
        ],
      ),
    );
  }
}