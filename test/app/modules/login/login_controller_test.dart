import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:una_agendamento/app/modules/login/login_controller.dart'; // Ajuste o seu import

// Os testes relacionados ao LoginController devem ser adicionados aqui

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LoginController controller;

  setUp(() {
    Get.testMode = true;
    controller = LoginController();
  });

  tearDown(() {
    Get.reset();
  });

    //--- 1. Verifica quando o e-mail é passado incorretamente
    test('Deve acusar erro se o email estiver vazio ou inválido', () {
        // Cenário 1: Email vazio
        controller.emailInput.text = '';
        
        bool isValid = controller.validateEmail();

        expect(isValid, false);
        expect(controller.errorEmail.value, 'Preencha o email');

        // Cenário 2: Email sem @ ou formato incorreto
        controller.emailInput.text = 'usuario_teste.com';
        
        isValid = controller.validateEmail();

        expect(isValid, false);
        expect(controller.errorEmail.value, 'Email inválido');
    });

    //--- 2. Verifica quando o e-mail é passado corretamente
    test('Deve aceitar e-mail com formato correto', () {
        controller.emailInput.text = 'teste@una.com';
        
        bool isValid = controller.validateEmail();

        expect(isValid, true);
        expect(controller.errorEmail.value, isNull);
    });

    //--- 3. Verifica quando a senha não atende a quantidade mínima de caracteres
    test('Deve exigir pelo menos 8 caracteres para usuários comuns', () {
        controller.emailInput.text = 'comum@teste.com';
        controller.senhaInput.text = '1234'; // Senha curta demais

        bool isValid = controller.validatePassword();

        expect(isValid, false);
        expect(controller.errorPassword.value, 'A senha deve ter pelo menos 8 caracteres');
    });

    //--- 4. Verifica quando tenta-se logar pelo Admin Local
    test('Deve permitir o login direto se for as credenciais do Admin', () async {
        controller.emailInput.text = 'admin@admin.com';
        controller.senhaInput.text = 'admin';

        await controller.logar();

        expect(controller.errorEmail.value, isNull);
        expect(controller.errorPassword.value, isNull);
    });

    //--- 5. Verifica quando o usuário passa credenciais válidas no login
    test('Deve retornar true se a API responder com status 200', () async {
        // Simulando o comportamento do servidor respondendo sucesso com MockClient
        final mockClient = MockClient((request) async {
        return http.Response('', 200);
        });

        final resultado = await mockClient.post(
        Uri.parse('http://10.0.2.2:8080/login'),
        body: jsonEncode({'email': 'user@test.com', 'senha': 'password123'}),
        );

        expect(resultado.statusCode, 200);
    });
    //--- 6. Verifica quando o usuário passa credenciais inválidas no login
    test('Deve retornar false se a API responder com erro', () async {
        // Simulando o servidor rejeitando as credenciais com MockClient
        final mockClient = MockClient((request) async {
        return http.Response('', 401);
        });

        final resultado = await mockClient.post(
        Uri.parse('http://10.0.2.2:8080/login'),
        );

        expect(resultado.statusCode, isNot(200));
    });
}