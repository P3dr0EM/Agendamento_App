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
            colorScheme: darkScheme,
            textTheme: Typography.material2021().white.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
            scaffoldBackgroundColor: darkScheme.surface,
            appBarTheme: AppBarTheme(
              backgroundColor: corRoxaPrincipal,
              foregroundColor: darkScheme.onPrimary,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[700],
                foregroundColor: Colors.white,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              floatingLabelStyle: TextStyle(color: Colors.grey[300]),
              labelStyle: TextStyle(color: Colors.grey[400]),
              hintStyle: TextStyle(color: Colors.grey[500]),
              helperStyle: TextStyle(color: Colors.grey[500]),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: corRoxaPrincipal.withAlpha((0.7 * 255).round())),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: corRoxaPrincipal),
              ),
              fillColor: Colors.grey[850],
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


