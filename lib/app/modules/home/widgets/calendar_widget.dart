import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../home_controller.dart';

/// Um widget que exibe um calendário dentro de um BottomSheet.
/// Ele é totalmente controlado pelo HomeController usando GetX.
class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Acessa o HomeController que já está em memória.
    final controller = Get.find<HomeController>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Alça visual para indicar que o sheet é "puxável"
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Selecione uma Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Obx garante que o calendário se reconstrua ao selecionar um dia.
            Obx(() {
              // O SEGREDO: Ler a lista reativa aqui fora avisa o Obx que ele
              // precisa redesenhar o calendário inteiro sempre que um novo dia for adicionado.
              final diasComAgendamento = controller.diasAgendados.toList();

              return TableCalendar(
                locale: 'pt_BR',
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: controller.focusedDay.value,
                calendarFormat: CalendarFormat.month,
                availableGestures: AvailableGestures.horizontalSwipe,

                selectedDayPredicate: (day) =>
                    isSameDay(controller.selectedDay.value, day),
                onDaySelected: controller.onDaySelected,

                onPageChanged: (focusedDay) {
                  controller.focusedDay.value = focusedDay;
                },

                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.black54,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.black54,
                  ),
                ),

                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: const TextStyle(color: Colors.black87),
                  selectedDecoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.red.shade400),
                  outsideDaysVisible: false,
                ),

                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.red),
                ),

                // Construtor dos Círculos
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    final normalizedDay = DateTime(
                      day.year,
                      day.month,
                      day.day,
                    );

                    // Usa a lista que carregamos no início do Obx
                    if (diasComAgendamento.contains(normalizedDay)) {
                      return Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2.5,
                            ),
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            // Botão de confirmação com estilo
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Confirmar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Formata a data para dd/MM/yyyy para o snackbar
                  final formattedDate =
                      "${controller.selectedDay.value.day.toString().padLeft(2, '0')}/${controller.selectedDay.value.month.toString().padLeft(2, '0')}/${controller.selectedDay.value.year}";

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Você escolheu: $formattedDate'),
                      backgroundColor: Colors.black87,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(12),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
