import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

class TelefoneField extends GetView<CadastroController> {
  const TelefoneField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Obx(
        () => TextField(
          controller:
              controller.telefoneInput, //chama o controlador do campo de texto
          keyboardType: TextInputType.number,
          maxLength: 9,
          focusNode: controller.telefoneFocus,
          textInputAction: TextInputAction.done,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          cursorColor: Theme.of(context).colorScheme.onSurface,
          decoration: InputDecoration(
            label: const Text("TELEFONE"),
            errorText:
                controller.errorTelefone.value, //chama o controlador de erro
            counterText: '', // Remove o contador de caracteres
          ),
        ),
      ),
    );
  }
}
