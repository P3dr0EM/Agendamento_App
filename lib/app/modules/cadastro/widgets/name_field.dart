import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_controller.dart';

//Construção do Widget do Campo de Email
class NameField extends GetView<CadastroController> {
  const NameField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Obx(
        () => TextField(
          controller:
              controller.nomeInput, //chama o controlador do campo de texto
          keyboardType: TextInputType.name,
          focusNode: controller.nomeFocus,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(controller.cpfFocus);
          },
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          cursorColor: Theme.of(context).colorScheme.onSurface,
          decoration: InputDecoration(
            label: const Text("NOME"),
            errorText: controller.errorNome.value, //chama o controlador de erro
          ),
        ),
      ),
    );
  }
}
