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
    final controller = Get.find<HomeController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withAlpha((0.2 * 255).round()),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Selecione uma Data',
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
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
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: colorScheme.onSurface,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurface,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSecondaryContainer,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  defaultTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  weekendTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: colorScheme.secondary,
                  ),
                  outsideDaysVisible: false,
                  outsideTextStyle: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.disabledColor,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: theme.textTheme.bodySmall!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  weekendStyle: theme.textTheme.bodySmall!.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    final normalizedDay = DateTime(
                      day.year,
                      day.month,
                      day.day,
                    );

                    if (diasComAgendamento.contains(normalizedDay)) {
                      return Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.primary,
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Confirmar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final formattedDate =
                      "${controller.selectedDay.value.day.toString().padLeft(2, '0')}/${controller.selectedDay.value.month.toString().padLeft(2, '0')}/${controller.selectedDay.value.year}";

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Você escolheu: $formattedDate'),
                      backgroundColor: colorScheme.surface,
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
