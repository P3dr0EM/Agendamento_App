import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/agendamento/agendamento_controller.dart';

class TimeSlotsWidget extends StatelessWidget {
  const TimeSlotsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgendamentoController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Obx para mostrar/esconder toda a área de horários
    return Obx(() {
      // Se nenhum dia estiver selecionado, não mostra nada
      if (controller.selectedDay.value == null) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Selecione um dia no calendário.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        );
      }

      // Se não houver horários, mostra mensagem
      if (controller.availableTimes.isEmpty) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Nenhum horário disponível para este dia.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ));
      }

      // Se houver horários, mostra o grid
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horários disponíveis',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          // O Wrap permite que os botões quebrem a linha
          Wrap(
            spacing: 12.0, // Espaço horizontal
            runSpacing: 12.0, // Espaço vertical
            children: controller.availableTimes.map((time) {
              // Obx para o estado de seleção de cada botão
              return Obx(() {
                final isSelected = controller.selectedTime.value == time;
                return ChoiceChip(
                  label: Text(time),
                  selected: isSelected,
                  onSelected: (selected) {
                    controller.selectTime(time);
                  },
                  selectedColor: colorScheme.primary,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? colorScheme.onPrimary
                        : colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              });
            }).toList(),
          ),
        ],
      );
    });
  }
}