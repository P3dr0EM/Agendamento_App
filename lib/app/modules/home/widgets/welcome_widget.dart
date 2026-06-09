import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Adiciona um preenchimento horizontal e vertical
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        // Alinha os itens verticalmente ao centro
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. MENSAGEM DE BOAS-VINDAS
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá,',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                'Bem-vindo!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D0890), // Usando a cor do seu app
                ),
              ),
            ],
          ),

          // 2. SPACER
          // O Spacer é um widget flexível que ocupa todo o espaço
          // disponível, empurrando os ícones para a direita.
          const Spacer(),

          // 3. ÍCONE DE INTERROGAÇÃO
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.grey[700], size: 26),
            tooltip: 'Como usar o app', // Texto de ajuda ao segurar
            onPressed: () {
              // Funcionalidade futura
              Get.snackbar(
                'Em Breve!',
                'Aqui você verá um guia de como usar o aplicativo.',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),

          // Espaçamento entre os ícones
          const SizedBox(width: 8),

          // 4. ÍCONE DE PERFIL (CÍRCULO)
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
            child: CircleAvatar(
              radius: 24, // "maior" que o ícone de interrogação
              backgroundColor: Colors.grey[300], // Cor de fundo placeholder
              // Futuramente, você usará backgroundImage para a foto do usuário:
              // backgroundImage: NetworkImage(controller.usuario.fotoUrl),
              child: Icon(
                Icons.person,
                color: Colors.grey[600], // Ícone de pessoa como placeholder
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}