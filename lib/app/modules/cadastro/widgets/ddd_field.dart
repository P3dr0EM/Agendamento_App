import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

//Construção do Widget do Campo de Email
class DddField extends GetView<CadastroController> {
  const DddField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Obx(
        () => TextField(
          controller:
              controller.dddInput, //chama o controlador do campo de texto
          keyboardType: TextInputType.number,
          maxLength: 3,
          focusNode: controller.dddFocus,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(
              controller.telefoneFocus,
            ); // Muda o foco para o telefone
          },
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          cursorColor: Theme.of(context).colorScheme.onSurface,
          decoration: InputDecoration(
            label: const Text("DDD"),
            errorText: controller.errorddd.value, //chama o controlador de erro
            counterText: '', // Remove o contador de caracteres
          ),
        ),
      ),
    );
  }
}
