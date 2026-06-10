import 'package:get/get.dart';
import 'package:una_agendamento/app/services/theme_service.dart';

class SettingsController extends GetxController {
  final ThemeService themeService;

  SettingsController({required this.themeService});

  RxBool get isDark => themeService.isDark;

  void toggleNightMode() {
    themeService.toggleTheme();
  }
}


