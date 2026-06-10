import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString userName = 'Usuário'.obs;
  final RxString avatarAsset = 'assets/icons/icone_app.png'.obs;

  final RxList<String> agendamentos = <String>[
    'Agendamento 1',
    'Agendamento 2',
  ].obs;
}

