import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/app/modules/login/login_controller.dart';

class PasswordField extends GetView<LoginController> {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsetsGeometry.only(left: 8, right: 8),
                child: Obx(()=> TextFormField(
                  controller: controller.senhaInput, //chama o controlador de texto
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  cursorColor: Theme.of(context).colorScheme.onSurface,
                  decoration: InputDecoration(
                    label: const Text("SENHA"),
                    errorText: controller.errorPassword.value,
                  ), //chama o controlador de erro   
                ),)
              );
  }
}