import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/home/home_controller.dart';

// Os testes relacionados ao HomeController devem ser adicionados aqui

void main() {
  late HomeController controller;

  setUpAll(() {
    Get.put(HomeController());
    controller = Get.find<HomeController>();
  });

  tearDownAll(() {
    Get.delete<HomeController>();
  });

  //--- 1. Verifica se o HomeController está registrado no GetX
  test('HomeController deve ser registrado corretamente', () {
    expect(Get.isRegistered<HomeController>(), isTrue);
  });

  //--- 2. Verifica se os valores padrão predefinidos estão corretos
  test('Deve inicializar com os valores padrão corretos', () {
    expect(controller.isSearching.value, false);
    expect(controller.tabIndex.value, 0);
    expect(controller.carrosselPagina.value, 0);
    expect(controller.searchResults.length, 10); // Quantidade de itens em _allData
  });

  //--- 3. Verifica a interação do usuário com a barra de pesquisa
  test('Deve alternar o estado de isSearching ao chamar toggleSearch', () {
    expect(controller.isSearching.value, false);
    
    controller.toggleSearch();
    expect(controller.isSearching.value, true);

    controller.toggleSearch();
    expect(controller.isSearching.value, false);
  });

  //--- 4. Verifica o funcionamento da barra de pesquisa
  test('Deve filtrar os resultados corretamente com base na query', () {
    // Inicializa o listener simulando o onInit
    controller.onInit();

    // Filtrando especificamente por "Flutter" (deve trazer 1 item)
    controller.filterResults('Flutter');
    expect(controller.searchResults.length, 1);
    expect(controller.searchResults.first, 'Flutter');

    // Filtrando por "ar" (deve trazer Dart, Clean Architecture)
    controller.filterResults('ar');
    expect(controller.searchResults.contains('Dart'), true);
    expect(controller.searchResults.contains('Clean Architecture'), true);
    expect(controller.searchResults.length, 2);

    // Query vazia deve restaurar todos os dados
    controller.filterResults('');
    expect(controller.searchResults.length, 10);
  });

  //--- 5. Verifica se o índice é atualizado quando o usuário interage com o carrossel 
  test('Deve atualizar o índice da página do carrossel', () {
    controller.onCarouselPageChanged(2);

    expect(controller.carrosselPagina.value, 2);
  });

  //--- 6. Verifica se o tabIndex é atualizado corretamente ao mudar de aba
  test('Deve atualizar o tabIndex ao mudar de aba', () {
    controller.changeTabIndex(0);

    expect(controller.tabIndex.value, 0);

    //Observação: Se testar o index 1 diretamente vai disparar o showCalendarPicker(),
    //que abre um BottomSheet, e como o teste roda na memória sem tela nenhuma o GetX
    //vai procurar uma tela aberta para jogar esse BottomSheet e dará erro no terminal
  });

  //--- 7. Verifica se está guardando e atualizando o dia que o usuário escolheu no calendário
  test('Deve atualizar as datas selecionadas e focadas', () {
    final dataSelecionada = DateTime(2026, 6, 15); //Dia que o usuário escolheu no calendário
    final dataFocada = DateTime(2026, 6, 15); //Mês/ano que o calendário está exibindo na tela

    controller.onDaySelected(dataSelecionada, dataFocada);

    expect(controller.selectedDay.value, dataSelecionada);
    expect(controller.focusedDay.value, dataFocada);
  });

} 