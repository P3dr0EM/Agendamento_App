import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/agendamento/agendamento_controller.dart';
import 'package:una_agendamento/app/modules/agendamento/widgets/calendar_card_widget.dart';
import 'package:una_agendamento/app/modules/agendamento/widgets/confirmation_buttom_widget.dart';
import 'package:una_agendamento/app/modules/agendamento/widgets/time_slots_widget.dart';
import 'package:una_agendamento/constants.dart';

class AgendamentoView extends GetView<AgendamentoController> {
  const AgendamentoView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      // O AppBar busca o nome do serviço do controller
      appBar: AppBar(
        title: Obx(() => Text('Agendar ${controller.serviceName.value}',
          style: TextStyle(
            color: theme.brightness == Brightness.dark ? preto : null,
          ),
        )),
        centerTitle: true,
      ),
      
      // O body é uma ListView para permitir rolagem em telas menores
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          // 1. O Widget do Calendário
          CalendarCardWidget(),
          
          SizedBox(height: 20),

          // 2. O Widget dos Horários Disponíveis
          TimeSlotsWidget(),
        ],
      ),
      
      // 3. O Widget do Botão de Confirmação no rodapé
      bottomNavigationBar: SafeArea(child: const ConfirmationButtonWidget()),
    );
  }
}