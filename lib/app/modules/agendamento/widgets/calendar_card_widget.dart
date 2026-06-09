
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:una_agendamento/app/modules/agendamento/agendamento_controller.dart';

class CalendarCardWidget extends StatelessWidget {
  const CalendarCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Encontra o controller que já foi inicializado pelo Binding
    final controller = Get.find<AgendamentoController>();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 4,
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() => TableCalendar(
              locale: 'pt_BR',
              focusedDay: controller.focusedDay.value,
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 60)),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) =>
                  controller.isSameDay(controller.selectedDay.value, day),
              onDaySelected: controller.onDaySelected,
              onPageChanged: (focused) => controller.focusedDay.value = focused,
              availableGestures: AvailableGestures.horizontalSwipe,
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
                defaultBuilder: (context, day, focusedDay) {
                  final status = controller.getDayStatus(day);
                  Color corTexto;
                  if (status == DayStatus.closed || status == DayStatus.past) {
                    corTexto = theme.disabledColor;
                  } else if (status == DayStatus.full) {
                    corTexto = colorScheme.secondary;
                  } else {
                    corTexto = colorScheme.onSurface;
                  }
                  return Center(
                    child: Text('${day.day}', style: TextStyle(color: corTexto)),
                  );
                },
                outsideBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(color: theme.disabledColor.withOpacity(0.7)),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${day.day}',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${day.day}',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}