// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:una_agendamento/app/services/theme_service.dart';
import 'package:una_agendamento/constants.dart';

import 'package:una_agendamento/app/routes/app_pages.dart';
import 'package:una_agendamento/app/services/data_format_service.dart';
import 'package:una_agendamento/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDateFormatting();
  // Logs para depuração do Firebase: mostra apps registrados e resultado
  print(
    'Firebase apps before init: ${Firebase.apps.map((a) => a.name).toList()}',
  );
  // Evita inicializar o Firebase mais de uma vez (causa: hot-reload/restart
  // ou inicialização duplicada em outros pontos do código).
  if (Firebase.apps.isEmpty) {
    print('Firebase not initialized yet — iniciando Firebase...');
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print(
        'Firebase inicializado com sucesso. Apps: ${Firebase.apps.map((a) => a.name).toList()}',
      );
    } catch (e, s) {
      // Tratar especificamente o caso de app duplicado (algumas integrações
      // ou hot-restart podem provocar esse erro). Não abortamos a execução,
      // apenas logamos e seguimos — assume-se que o Firebase já está pronto.
      if (e is FirebaseException && e.code == 'core/duplicate-app') {
        print('Ignore: Firebase app já existe (duplicate-app). Prosseguindo.');
      } else {
        print('Erro ao inicializar o Firebase: $e');
        print(s);
      }
    }
  } else {
    print(
      'Firebase já estava inicializado. Apps: ${Firebase.apps.map((a) => a.name).toList()}',
    );
  }
  // ThemeService + GetStorage
  // Importante: GetStorage.init() precisa rodar antes do app.
  await GetStorage.init();
  Get.put<ThemeService>(ThemeService(), permanent: true);
  await Get.find<ThemeService>().init();

  runApp(const MyApp());
}

// Construção do Main
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();

    return GetX<ThemeService>(
      init: themeService,
      builder: (_) {
        final lightScheme = ColorScheme.fromSeed(
          seedColor: corRoxaPrincipal,
          brightness: Brightness.light,
        );
        final darkScheme = ColorScheme.fromSeed(
          seedColor: corRoxaPrincipal,
          brightness: Brightness.dark,
        );

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightScheme,
            textTheme: Typography.material2021().black.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
            scaffoldBackgroundColor: lightScheme.surface,
            appBarTheme: AppBarTheme(
              backgroundColor: corRoxaPrincipal,
              foregroundColor: lightScheme.onPrimary,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              floatingLabelStyle: TextStyle(color: Colors.grey[900]),
              labelStyle: TextStyle(color: Colors.grey[800]),
              hintStyle: TextStyle(color: Colors.grey[700]),
              helperStyle: TextStyle(color: Colors.grey[700]),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: corRoxaPrincipal.withAlpha((0.7 * 255).round())),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: corRoxaPrincipal),
              ),
              fillColor: Colors.grey[50],
              filled: true,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFB05CFF),
              brightness: Brightness.dark,
            ),
            textTheme: Typography.material2021().white.apply(
              bodyColor: const Color(0xFFFFFFFF),
              displayColor: const Color(0xFFFFFFFF),
            ),
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFFB05CFF),
              foregroundColor: const Color(0xFFFFFFFF),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF333333),
                foregroundColor: const Color(0xFFFFFFFF),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              floatingLabelStyle: const TextStyle(color: Color(0xFFC77DFF)),
              labelStyle: const TextStyle(color: Color(0xFFB0B0B0)),
              hintStyle: const TextStyle(color: Color(0xFF808080)),
              helperStyle: const TextStyle(color: Color(0xFF808080)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFB05CFF)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC77DFF)),
              ),
              fillColor: const Color(0xFF1E1E1E),
              filled: true,
            ),
          ),
          themeMode: themeService.theme,
          // 4. Adicione as configurações de localização ao GetMaterialApp
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'), // Adiciona o suporte para Português do Brasil
          ],
          locale: const Locale('pt', 'BR'), // Define como o locale padrão
        );
      },
    );
  }
}


