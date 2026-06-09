import 'package:get/get.dart';
import 'package:una_agendamento/app/services/theme_service.dart';
import 'settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    // ThemeService é singleton/put no main.dart
    Get.lazyPut(
      () => SettingsController(themeService: Get.find<ThemeService>()),
    );
  }
}

