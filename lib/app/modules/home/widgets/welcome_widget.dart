import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';
import 'dart:ui';
import 'tutorialOverlay_widget.dart'; // Certifique-se de que o nome do arquivo bate com o seu

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
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
                  color: Color(0xFF5D0890), 
                ),
              ),
            ],
          ),

          // 2. SPACER
          const Spacer(),

          // 3. ÍCONE DE INTERROGAÇÃO
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.grey[700], size: 26),
            tooltip: 'Como usar o app',
            onPressed: () {
              Get.dialog(
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), 
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.help_outline, size: 50, color: Colors.purple),
                          const SizedBox(height: 16),
                          const Text(
                            'Tutorial',
                            style: TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none, 
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Você gostaria de iniciar o tutorial?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.none,
                              color: Colors.black87,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          // --- INÍCIO DOS BOTÕES ---
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                            children: [
                              // BOTÃO NÃO
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red, 
                                  padding: const EdgeInsets.symmetric(horizontal: 24), 
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Fecha o diálogo
                                },
                                child: const Text('Não', style: TextStyle(color: Colors.white)),
                              ),
                              
                              // BOTÃO SIM
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Fecha a pergunta

                                  // Abre a tela do tutorial
                                  Get.dialog(
                                    const TutorialOverlay(),
                                    useSafeArea: false, 
                                    barrierColor: Colors.transparent, 
                                  );
                                },
                                child: const Text('Sim', style: TextStyle(color: Colors.white)),
                              ), 
                            ],
                          ),
                          // --- FIM DOS BOTÕES ---
                        ],
                      ),
                    ),
                  ),
                ),
                barrierColor: Colors.black.withOpacity(0.2), 
              );
            },
          ),

          const SizedBox(width: 8),

          // 4. ÍCONE DE PERFIL
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
            child: CircleAvatar(
              radius: 24, 
              backgroundColor: Colors.grey[300], 
              child: Icon(
                Icons.person,
                color: Colors.grey[600], 
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}