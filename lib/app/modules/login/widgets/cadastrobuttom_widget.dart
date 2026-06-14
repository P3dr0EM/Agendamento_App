import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';

class CadastroButtom extends StatelessWidget {
  const CadastroButtom({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Não possui uma conta?",
          style: TextStyle(
            color: isDark ? const Color(0xFFBDBDBD) : Colors.grey[700],
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.CADASTRO);
          },
          child: Text(
            "Cadastre-se",
            style: TextStyle(
              color: isDark ? const Color(0xFFC77DFF) : const Color(0xFF5D0890),
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}