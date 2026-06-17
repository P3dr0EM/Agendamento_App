// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// Classe principal que define o StatefulWidget
class CheckboxField extends StatefulWidget {
  const CheckboxField({super.key});

  @override
  State<CheckboxField> createState() => _TitledCheckboxField();
}

// A classe de Estado
class _TitledCheckboxField extends State<CheckboxField> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsetsGeometry.only(left: 8, right: 8),
      child: CheckboxListTile(
        title: Text(
          'Lembrar de mim',
          style: TextStyle(
            color: isDark ? const Color(0xFFBDBDBD) : Colors.black87,
          ),
        ),
        value: rememberMe,
        onChanged: (bool? value) {
          setState(() {
            rememberMe = value!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: const Color(0xFFB05CFF),
        checkColor: const Color(0xFFFFFFFF),
        fillColor: MaterialStateProperty.resolveWith((
          Set<MaterialState> states,
        ) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFFB05CFF);
          }
          return isDark ? const Color(0xFF333333) : Colors.grey[300];
        }),
      ),
    );
  }
}
