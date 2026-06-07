import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/home/home_controller.dart';

void main() {
  setUpAll(() {
    Get.put(HomeController());
  });

  tearDownAll(() {
    Get.delete<HomeController>();
  });
  
  test('HomeController deve ser registrado corretamente', () {
    // Verifica se o HomeController está registrado no GetX
    expect(Get.isRegistered<HomeController>(), isTrue);
  });

  // Outros testes relacionados ao HomeController podem ser adicionados aqui
} 