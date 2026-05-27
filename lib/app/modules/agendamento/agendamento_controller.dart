// ignore_for_file: avoid_print
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Enum para os status do dia
enum DayStatus { available, full, closed, past }

class AgendamentoController extends GetxController {
  // --- ESTADO DO SERVIÇO ---
  final serviceName = 'Serviço'.obs;

  // --- ESTADO DO CALENDÁRIO ---
  final focusedDay = DateTime.now().obs;
  final selectedDay = Rxn<DateTime>(); // Dia selecionado (pode ser nulo)

  // --- ESTADO DOS HORÁRIOS ---
  final availableTimes = <String>[].obs; // Lista de horários disponíveis
  final selectedTime = Rxn<String>(); // Horário selecionado (pode ser nulo)

  // --- DADOS MOCKADOS (Simulação de um banco de dados) ---
  // Simula dias que não funcionam (ex: Domingo)
  final List<int> diasFechados = [DateTime.sunday];
  // Simula dias que estão lotados (ex: dia 25 do mês)
  final List<int> diasLotados = [25];

  // --- COMPUTED (Getters Reativos) ---

  /// Texto reativo para o botão de confirmação
  String get confirmationText {
    if (selectedDay.value == null) {
      return 'Selecione um dia';
    }
    if (selectedTime.value == null) {
      return 'Selecione um horário';
    }
    // Formata a data (ex: 15/11)
    final String diaFormatado = DateFormat('dd/MM').format(selectedDay.value!);
    return 'Confirmar: $diaFormatado às ${selectedTime.value!}';
  }

  /// Verifica se o botão de confirmar deve estar ativo
  bool get isConfirmationButtonEnabled {
    return selectedDay.value != null && selectedTime.value != null;
  }

  // Local notifications plugin
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> _initLocalNotifications() async {
    // Android continua igual
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // ATUALIZAÇÃO: iOS agora usa DarwinInitializationSettings
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      initSettings,
      // ATUALIZAÇÃO: 'onSelectNotification' mudou para 'onDidReceiveNotificationResponse'
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // O payload agora fica dentro de response.payload
        if (response.payload != null) {
          print('Notificação clicada com payload: ${response.payload}');
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    // Pega o nome do serviço da URL (ex: "dentista")
    String servicoKey = Get.parameters['servico'] ?? 'servico';
    // Converte para "Dentista" (primeira letra maiúscula)
    serviceName.value = servicoKey.capitalizeFirst ?? 'Serviço';

    // Inicializa local notifications
    _initLocalNotifications();
  }

  /// Função chamada pelo TableCalendar ao selecionar um dia
  void onDaySelected(DateTime day, DateTime focused) {
    // Não permite selecionar dias passados
    if (getDayStatus(day) == DayStatus.past) {
      return;
    }

    focusedDay.value = focused;
    // Se clicar no mesmo dia, limpa a seleção
    if (isSameDay(selectedDay.value, day)) {
      selectedDay.value = null;
      selectedTime.value = null;
      availableTimes.clear();
    } else {
      selectedDay.value = day;
      selectedTime.value = null;
      // Carrega os horários para o dia selecionado
      _loadAvailableTimes(day);
    }
  }

  /// Função chamada ao clicar em um botão de horário
  void selectTime(String time) {
    selectedTime.value = time;
  }

  /// Função para simular a busca de horários em um API/Banco de Dados
  void _loadAvailableTimes(DateTime day) {
    // Simulação de carregamento
    availableTimes.clear();

    // Simula horários diferentes para dias diferentes
    if (day.weekday == DateTime.saturday) {
      // Sábado tem menos horários
      availableTimes.assignAll(['09:00', '10:00', '11:00']);
    } else {
      // Dias de semana
      availableTimes.assignAll([
        '09:00',
        '10:00',
        '11:00',
        '14:00',
        '15:00',
        '16:00',
      ]);
    }
  }

  /// Retorna o status de um dia para o builder do calendário
  DayStatus getDayStatus(DateTime day) {
    // Normaliza 'day' para ignorar a hora
    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final normalizedDay = DateTime(day.year, day.month, day.day);

    if (normalizedDay.isBefore(normalizedToday)) {
      return DayStatus.past;
    }
    if (diasFechados.contains(day.weekday)) {
      return DayStatus.closed;
    }
    if (diasLotados.contains(day.day)) {
      return DayStatus.full;
    }
    return DayStatus.available;
  }

  /// Função do botão de confirmação
  Future<void> confirmarAgendamento() async {
    // Validação mínima
    if (selectedDay.value == null || selectedTime.value == null) {
      Get.snackbar('Erro', 'Selecione dia e horário');
      return;
    }

    // Monta a DateTime de início a partir do `selectedDay` + `selectedTime` (formato 'HH:mm')
    final parts = selectedTime.value!.split(':');
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    final start = DateTime(
      selectedDay.value!.year,
      selectedDay.value!.month,
      selectedDay.value!.day,
      hour,
      minute,
    );
    final end = start.add(const Duration(hours: 1));

    // Tenta criar evento no Google Calendar
    final created = await _createGoogleCalendarEvent(
      title: serviceName.value,
      start: start,
      end: end,
    );

    if (created) {
      // Notificação local de confirmação imediata
      await _showLocalConfirmationNotification(start);
      final diaFormatado = DateFormat('dd/MM/yyyy').format(start);
      final horaFormatada = DateFormat('HH:mm').format(start);

      Get.defaultDialog(
        title: 'Agendamento Confirmado',
        middleText:
            'Seu agendamento para $serviceName em $diaFormatado às $horaFormatada foi confirmado e adicionado ao seu Google Calendar.',
        onConfirm: () {
          Get.back(); // Fecha o diálogo
          Get.back(); // Volta para a tela anterior
        },
        textConfirm: 'OK',
      );      
    }
  }

  // Cria um evento no calendário primário do usuário usando a API REST com
  // o token obtido via GoogleSignIn. Retorna true se criado com sucesso.
  Future<bool> _createGoogleCalendarEvent({
    required String title,
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      // Use uma instância compartilhada com o scope de calendar para garantir
      // que o token tenha permissão de criar eventos.
      final googleSignIn = GoogleSignIn(
        scopes: <String>['email', 'https://www.googleapis.com/auth/calendar'],
      );

      GoogleSignInAccount? account = googleSignIn.currentUser;
      account ??= await googleSignIn.signInSilently();

      // Se já estiver logado mas sem as permissões necessárias, solicite scopes
      if (account != null) {
        try {
          // requestScopes pede explicitamente as scopes adicionais (se necessário)
          await googleSignIn.requestScopes([
            'https://www.googleapis.com/auth/calendar',
          ]);
        } catch (_) {
          // Ignora falha aqui — vamos garantir login interativo abaixo se necessário
        }
      }

      // Caso não esteja logado (ou requestScopes não concedeu), solicita login interativo
      account ??= await googleSignIn.signIn();

      if (account == null) {
        print('Google Calendar: usuário não autenticado');
        return false;
      }

      final auth = await account.authentication;
      final accessToken = auth.accessToken;
      if (accessToken == null) {
        print('Google Calendar: accessToken não disponível');
        return false;
      }

      final uri = Uri.parse(
        'https://www.googleapis.com/calendar/v3/calendars/primary/events',
      );
      final body = jsonEncode({
        'summary': title,
        'start': {
          'dateTime': start.toIso8601String(),
          'timeZone': DateTime.now().timeZoneName,
        },
        'end': {
          'dateTime': end.toIso8601String(),
          'timeZone': DateTime.now().timeZoneName,
        },
      });

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: body,
      );

      // Log detalhado para diagnóstico (status + body)
      print('Google Calendar: response.statusCode=${response.statusCode}');
      print('Google Calendar: response.body=${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Google Calendar: evento criado com sucesso');
        return true;
      } else {
        // Possíveis causas comuns:
        // - Token sem scope calendar (401 / 403)
        // - Calendar API não habilitada no Google Cloud Console (403)
        // - OAuth consent / SHA-1 not configured for Android (403)
        return false;
      }
    } catch (e, s) {
      print('Google Calendar: exceção ao criar evento: $e');
      print(s);
      return false;
    }
  }

  Future<void> _showLocalConfirmationNotification(DateTime start) async {
    const androidDetails = AndroidNotificationDetails(
      'agendamento_channel',
      'Agendamentos',
      channelDescription: 'Notificações de agendamentos',
      importance: Importance.max,
      priority: Priority.high,
    );

    // ATUALIZAÇÃO: IOSNotificationDetails virou DarwinNotificationDetails
    const iosDetails = DarwinNotificationDetails();
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final formatted = DateFormat('dd/MM/yyyy HH:mm').format(start);
    
    await _localNotifications.show(
      start.hashCode & 0x7FFFFFFF,
      'Agendamento confirmado',
      '$serviceName foi marcado para $formatted',
      details,
    );
  }

  /// Helper para comparar datas ignorando a hora
  bool isSameDay(DateTime? a, DateTime b) {
    if (a == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
