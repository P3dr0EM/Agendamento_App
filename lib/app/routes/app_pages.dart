import 'package:get/get_navigation/get_navigation.dart';
import 'package:una_agendamento/app/modules/agendamento/agendamento_bindings.dart';
import 'package:una_agendamento/app/modules/agendamento/agendamento_view.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro_binding.dart';
import 'package:una_agendamento/app/modules/cadastro/cadastro.view.dart';
import 'package:una_agendamento/app/modules/home/home.view.dart';
import 'package:una_agendamento/app/modules/home/home_bidings.dart';
import 'package:una_agendamento/app/modules/login/login.view.dart';
import 'package:una_agendamento/app/modules/login/login_bindings.dart';
import 'package:una_agendamento/app/modules/profile/profile_binding.dart';
import 'package:una_agendamento/app/modules/profile/profile_page.dart';
import 'package:una_agendamento/app/modules/settings/settings_binding.dart';
import 'package:una_agendamento/app/modules/settings/settings_page.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';


class AppPages {
  //Define a rota inicial do app
  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.CADASTRO,
      page: () => const CadastroView(),
      binding: CadastroBinding(),
    ),
    GetPage(
      name: '${Routes.AGENDAMENTO}/:servico', // Ex: /agendamento/dentista
      page: () => const AgendamentoView(),
      binding: AgendamentoBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBidings(),
    ),
    // Profile & Settings
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
  ];
}

