import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/agendamento/agendamento_controller.dart';

// Os testes relacionados ao AgendamentoController devem ser adicionados aqui

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AgendamentoController controller;

  setUp(() {
    Get.testMode = true;

    // Simula o parâmetro que o GetX recebe da URL da rota (ex: /agendamento/dentista)
    Get.parameters = {'servico': 'dentista'};

    controller = AgendamentoController();
    controller.onInit();
  });

  tearDown(() {
    Get.reset();
  });

  //--- 1. Verifica se o nome do serviço foi formatado corretamente
  test(
    'Deve capturar o nome do serviço da rota e formatar com a primeira letra maiúscula',
    () {
      // No setup foi passado "dentista" minúsculo
      expect(controller.serviceName.value, 'Dentista');
    },
  );

  //--- 2. Verifica se o dia anterior está definido como passado
  test('Deve identificar um dia anterior a hoje como DayStatus.past', () {
    final ontem = DateTime.now().subtract(const Duration(days: 1));

    final status = controller.getDayStatus(ontem);

    expect(status, DayStatus.past);
  });

  //--- 3. Verifica se no Domingo os serviços estão fora da funcionamento
  test('Deve identificar o próximo Domingo como DayStatus.closed', () {
    // Encontra um dia futuro que caia no domingo
    DateTime diaProximo = DateTime.now();
    while (diaProximo.weekday != DateTime.sunday) {
      diaProximo = diaProximo.add(const Duration(days: 1));
    }

    final status = controller.getDayStatus(diaProximo);

    // Não há como fazer agendamento no domingo
    expect(status, DayStatus.closed);
  });

  //--- 4. Verifica se o dia selecionado trata-se de uma data reatroativa
  test('Deve recusar a seleção de um dia que já passou', () {
    final ontem = DateTime.now().subtract(const Duration(days: 1));

    controller.onDaySelected(ontem, ontem);

    expect(controller.selectedDay.value, isNull);
  });

  //--- 5. Verifica se no sábado as opções de horários disponíveis foram reduzidas
  test('Deve carregar menos horários se o dia selecionado for um Sábado', () {
    // Sábado futuro para evitar problemas de data retroativa
    DateTime sabadoFuturo = DateTime.now().add(const Duration(days: 1));
    while (sabadoFuturo.weekday != DateTime.saturday) {
      sabadoFuturo = sabadoFuturo.add(const Duration(days: 1));
    }

    controller.onDaySelected(sabadoFuturo, sabadoFuturo);

    // Sábado tem menos horários disponíveis: 09:00, 10:00 e 11:00

    expect(controller.availableTimes.length, 3);
    expect(controller.availableTimes.contains('09:00'), true);
    expect(controller.availableTimes.contains('14:00'), false);
  });

  //--- 6. Verifica se a seleção foi limpa ao clicar no mesmo dia que estava
  test(
    'Deve limpar a seleção se o usuário clicar no mesmo dia que já estava',
    () {
      final dia = DateTime.now().add(const Duration(days: 1));

      // Primeiro clique: seleciona o dia
      controller.onDaySelected(dia, dia);
      controller.selectTime('09:00');

      // Segundo clique: clica no MESMO dia
      controller.onDaySelected(dia, dia);

      // Deve retornar tudo para o estado padrão
      expect(controller.selectedDay.value, isNull);
      expect(controller.selectedTime.value, isNull);
      expect(controller.availableTimes.isEmpty, true);
    },
  );

  //--- 7. Verifica o estado do botão de confirmação de acordo com as ações do usuário
  test(
    'Deve gerenciar o texto e o estado do botão de confirmação conforme as seleções',
    () {
      // Estado Inicial: Sem nada selecionado
      expect(controller.isConfirmationButtonEnabled, false);
      expect(controller.confirmationText, 'Selecione um dia');

      // Seleciona um dia
      DateTime quartaFutura = DateTime.now().add(const Duration(days: 1));
      while (quartaFutura.weekday != DateTime.wednesday) {
        quartaFutura = quartaFutura.add(const Duration(days: 1));
      }
      controller.onDaySelected(quartaFutura, quartaFutura);

      expect(controller.isConfirmationButtonEnabled, false);
      expect(controller.confirmationText, 'Selecione um horário');

      // Seleciona um horário
      controller.selectTime('10:00');

      // Com o Dia e Horários definidos (!=null) o botão deve ser ativado
      expect(controller.isConfirmationButtonEnabled, true);

      // Se o dia for 15/06, o texto esperado será 'Confirmar: 15/06 às 10:00'
      expect(controller.confirmationText.contains('Confirmar:'), true);
      expect(controller.confirmationText.contains('às 10:00'), true);
    },
  );
}
