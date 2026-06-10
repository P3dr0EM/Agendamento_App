// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:una_agendamento/app/modules/home/widgets/calendar_widget.dart';
import 'package:una_agendamento/app/routes/app_routes.dart';
import 'package:una_agendamento/constants.dart';

class HomeController extends GetxController {
  final isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final diasAgendados = <DateTime>[].obs;

  final _allData = <String>[
    'Flutter',
    'GetX',
    'State Management',
    'Dart',
    'Firebase',
    'API REST',
    'Clean Architecture',
    'SOLID',
    'Widget',
    'UI/UX',
  ].obs;

  final searchResults = <String>[].obs;

  //Variável para rastrear o índice do item selecionado no rodapé
  final tabIndex = 0.obs;

  // --- NOVO ESTADO PARA O CALENDÁRIO ---
  // Guarda a data que está atualmente em foco ou selecionada.
  var focusedDay = DateTime.now().obs;
  // Guarda a data efetivamente selecionada pelo usuário.
  var selectedDay = DateTime.now().obs;

  final carrosselPagina = 0.obs; //índice da página atual do carrossel

  //lista das imagens do carrossel
  final List<String> bannerItems = [
    'assets/images/imagemBanner01.png',
    'assets/images/imagemBanner02.png',
    'assets/images/imagemBanner03.png',
  ];

  //lista dos icones de serviços
  final List<Map<String, String>> servicosPopulares = [
    {
      "nome": "Dentista",
      "icone": "assets/icons/dentista.png",
      "rotaKey": "dentista",
    },
    {
      "nome": "Psicologo",
      "icone": "assets/icons/Célebro.png",
      "rotaKey": "psicologo",
    },
    {
      "nome": "Veterinária",
      "icone": "assets/icons/pet.png",
      "rotaKey": "veterinaria",
    },
    {"nome": "Exames", "icone": "assets/icons/exame.png", "rotaKey": "exames"},
    {
      "nome": "Financeiro",
      "icone": "assets/icons/financeiro.png",
      "rotaKey": "financeiro",
    },
    {
      "nome": "Fisioterapia",
      "icone": "assets/icons/fisioterapia.png",
      "rotaKey": "psicologo",
    },
    {
      "nome": "Medicina",
      "icone": "assets/icons/medicina.png",
      "rotaKey": "medicina",
    },
  ];

  /// Função chamada ao clicar em um bloco de serviço
  void navegarParaServico(String rotaKey, String nomeServico) async {
    print("Navegando para $rotaKey (Serviço: $nomeServico)");

    // 2. A navegação continua igual
    final dynamic resultado = await Get.toNamed(
      '${Routes.AGENDAMENTO}/$rotaKey',
    );

    // 3. A verificação continua igual
    if (resultado == true) {
      // 4. A SOLUÇÃO:
      // Nós ainda esperamos pelo próximo frame, para garantir
      // que o contexto da HomeView esteja 100% ativo.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 5. Pegamos o contexto atual e seguro do GetMaterialApp
        final BuildContext? context = Get.key.currentContext;

        // 6. Se o contexto existir (e ele vai existir),
        //    usamos o ScaffoldMessenger NATIVO do Flutter.
        if (context != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Agendamento Confirmado! Seu horário para $nomeServico foi marcado!',
              ),
              backgroundColor: corRoxaPrincipal, // A cor do seu app
              behavior:
                  SnackBarBehavior.floating, // (Opcional, mas fica bonito)
            ),
          );
        }
      });
    }
  }

  void onCarouselPageChanged(int index) {
    carrosselPagina.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    searchResults.assignAll(_allData);
    searchController.addListener(() {
      filterResults(searchController.text);
    });
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Esta função só roda DEPOIS que a tela for redesenhada.
        // Agora, temos certeza que o TextField existe antes de focar nele.
        searchFocusNode.requestFocus();
      });
    }
  }

  void filterResults(String query) {
    if (query.isEmpty) {
      searchResults.assignAll(_allData);
    } else {
      final filtered = _allData
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
      searchResults.assignAll(filtered);
    }
  }

  void showCalendarPicker() async {
    // 2. 'await' pelo resultado do BottomSheet
    final dynamic result = await Get.bottomSheet(
      const CalendarWidget(),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
    );

    // 3. Se um resultado (data formatada) foi retornado...
    if (result != null && result is String) {
      // 4. APLICA A MESMA SOLUÇÃO ROBUSTA DA OUTRA FUNÇÃO
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Pega o contexto seguro do GetMaterialApp
        final BuildContext? context = Get.key.currentContext;
        if (context != null && context.mounted) {
          // Usa o ScaffoldMessenger nativo do Flutter
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data Confirmada. Você escolheu: $result'),
              backgroundColor: Colors.black87, // Pode customizar
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    }
  }

  /// Atualiza a data selecionada a partir do widget do calendário.
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  /// Altera o índice da aba selecionada no rodapé.
  void changeTabIndex(int index) {
    if (index == 1) {
      tabIndex.value = index;
      showCalendarPicker();
      return;
    }

    if (index == 2) {
      // Navega para a tela de perfil em vez de ficar preso no mesmo índice.
      Get.toNamed(Routes.PROFILE);
      // Reseta o índice para não manter o item de perfil selecionado quando voltar ao Home.
      tabIndex.value = 0;
      return;
    }

    tabIndex.value = index;
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}
