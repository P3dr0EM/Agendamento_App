// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/login/login_controller.dart';
import 'package:una_agendamento/app/modules/login/widgets/cadastrobuttom_widget.dart';
import 'package:una_agendamento/app/modules/login/widgets/checkbox_field.dart';
import 'package:una_agendamento/app/modules/login/widgets/email_field.dart';
import 'package:una_agendamento/app/modules/login/widgets/forget_password.dart';
import 'package:una_agendamento/app/modules/login/widgets/google_button.dart';
import 'package:una_agendamento/app/modules/login/widgets/login_button.dart';
import 'package:una_agendamento/app/modules/login/widgets/password_field.dart';
import 'package:una_agendamento/constants.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  static const Color fieldBorderColor = Colors.grey;
  static const Color fieldLabelColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: corRoxaPrincipal,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 10.0,
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 500),
                            child: Image.asset(
                              "assets/images/unaLogo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            decoration: BoxDecoration(
                              color: isDark ? cinzaEscuro : branco,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 30,
                            ),

                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "Bem-Vindo!",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: corRoxaPrincipal,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const EmailField(),
                                const SizedBox(height: 10),
                                const PasswordField(),
                                const SizedBox(height: 10),
                                const ForgetPassword(),
                                const CheckboxField(),
                                const SizedBox(height: 10),
                                LogarGoogle(),
                                const SizedBox(height: 10),
                                const SizedBox(height: 10),
                                const LoginButton(),
                                const SizedBox(height: 10),
                                CadastroButtom(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
