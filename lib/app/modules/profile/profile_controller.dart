import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Variáveis observáveis (Estado)
  final RxString userName = 'Usuário'.obs;
  final RxString avatarAsset = 'assets/icons/icone_app.png'.obs;
  final RxList<String> agendamentos = <String>[].obs;
  
  // Controle de carregamento
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Inicia buscando os agendamentos quando o controller é criado
    fetchAgendamentos();
  }

  // --- FUNÇÕES GENÉRICAS --- //

  /// Simula uma chamada à API para buscar os agendamentos do usuário
  Future<void> fetchAgendamentos() async {
    isLoading.value = true;
    try {
      // Simula um delay de rede (2 segundos)
      await Future.delayed(const Duration(seconds: 2));
      
      // Popula a lista com dados mockados
      agendamentos.assignAll([
        'Consulta de Rotina - 15/10',
        'Exame Laboratorial - 20/10',
      ]);
    } catch (e) {
      Get.snackbar('Erro', 'Não foi possível carregar os agendamentos.');
    } finally {
      isLoading.value = false;
    }
  }

  /// Lógica para alterar a foto de perfil (ex: abrir Image Picker)
  void changeAvatar() {
    // Aqui você implementaria o image_picker
    Get.snackbar(
      'Alterar Foto',
      'Abrindo câmera ou galeria...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Lógica para edição de perfil
  void editProfile() {
    // Exemplo real: Get.toNamed(Routes.EDIT_PROFILE);
    Get.snackbar(
      'Editar perfil',
      'Navegando para a tela de edição...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Lógica para abrir os detalhes de um agendamento específico
  void openAgendamentoDetails(String agendamentoId) {
    // Exemplo real: Get.toNamed(Routes.AGENDAMENTO_DETAILS, arguments: agendamentoId);
    Get.snackbar(
      'Agendamento',
      'Abrindo os detalhes de: $agendamentoId',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Função genérica de Logout
  void logout() {
    Get.defaultDialog(
      title: 'Sair da conta',
      middleText: 'Tem certeza que deseja sair do aplicativo?',
      textConfirm: 'Sim, sair',
      textCancel: 'Cancelar',
      confirmTextColor: Get.theme.colorScheme.onPrimary,
      buttonColor: Get.theme.colorScheme.error,
      onConfirm: () {
        // Exemplo: Limpar tokens no SharedPreferences/GetStorage
        // Get.offAllNamed(Routes.LOGIN);
        Get.back(); // Fecha o dialog no mock
        Get.snackbar('Logout', 'Sessão encerrada com sucesso.');
      },
    );
  }
}