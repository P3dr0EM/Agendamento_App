import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxService {
  static const String _storageKey = 'isDarkMode';

  final RxBool isDark = false.obs;

  final GetStorage _box = GetStorage();

  Future<void> init() async {
    // Garantir que o GetStorage está inicializado no main.dart.
    // Aqui apenas lemos o valor persistido.
    final saved = _box.read<bool?>(_storageKey);
    if (saved != null) {
      isDark.value = saved;
    }
  }

  ThemeMode get theme => isDark.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDark.toggle();
    Get.changeThemeMode(theme);
    saveTheme();
  }

  Future<void> saveTheme() async {
    await _box.write(_storageKey, isDark.value);
  }
}

