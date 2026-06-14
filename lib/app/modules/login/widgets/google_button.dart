import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:una_agendamento/app/modules/login/login_controller.dart';

// Botão de login com Google mostrando estado de carregamento via GetX

class LogarGoogle extends GetView<LoginController> {
  const LogarGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Obx(() {
        final loading = controller.isLoading.value;
        return ElevatedButton.icon(
          onPressed: loading ? null : controller.tryToGoogleLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? const Color(0xFF262626) : Colors.white,
            foregroundColor: isDark ? const Color(0xFFFFFFFF) : Colors.black87,
            side: BorderSide(
              color: isDark ? const Color(0xFF333333) : Colors.grey[300]!,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          icon: loading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: isDark ? const Color(0xFFB05CFF) : Colors.black,
                  ),
                )
              : Image.asset(
                  "assets/icons/g_icon_google.png",
                  width: 20.0,
                  height: 20.0,
                ),
          label: Text(
            loading ? 'Entrando...' : 'Logar com Google',
            style: TextStyle(
              color: isDark ? const Color(0xFFFFFFFF) : Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }),
    );
  }
}
