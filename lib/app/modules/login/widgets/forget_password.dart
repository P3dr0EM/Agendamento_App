import 'package:flutter/material.dart';
import 'package:una_agendamento/constants.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsetsGeometry.only(left: 8, right: 8),
      child: GestureDetector(
        onTap: () {
          // Ação para recuperar senha
        },
        child: Text(
          "Esqueceu a senha? Clique aqui!",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: isDark ? const Color(0xFFC77DFF) : corRoxaPrincipal,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}