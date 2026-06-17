// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, deprecated_member_use

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:una_agendamento/app/modules/agendamento/agendamento_controller.dart';

class TutorialOverlay extends StatefulWidget {
  final int initialStep;

  const TutorialOverlay({super.key, this.initialStep = 0});

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> {
  late int _passoAtual;
  bool _mostrarConteudo = false;
  Animation<double>? _routeAnimation;

  @override
  void initState() {
    super.initState();
    _passoAtual = widget.initialStep;
    if (_passoAtual == 3) {
      _mostrarConteudo = false;
    } else {
      _mostrarConteudo = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_routeAnimation == null) {
      _routeAnimation = ModalRoute.of(context)?.animation;

      if (_passoAtual == 3 &&
          _routeAnimation != null &&
          !_routeAnimation!.isCompleted) {
        _routeAnimation!.addStatusListener(_handleAnimationStatus);
      } else {
        if (!_mostrarConteudo) {
          setState(() => _mostrarConteudo = true);
        }
      }
    }
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _routeAnimation?.removeStatusListener(_handleAnimationStatus);
      if (mounted) {
        setState(() => _mostrarConteudo = true);
      }
    }
  }

  @override
  void dispose() {
    _routeAnimation?.removeStatusListener(_handleAnimationStatus);
    super.dispose();
  }

  void _proximoPasso() {
    setState(() => _passoAtual++);
    if (_passoAtual > 5) {
      _finalizarTutorial();
    }
  }

  // --- Função extraída para simular a seleção de data e avançar no passo 3 ---
  void _avancarPasso3() {
    try {
      final controller = Get.find<AgendamentoController>();
      DateTime dataSimulada = DateTime.now().add(const Duration(days: 1));
      if (dataSimulada.weekday == DateTime.sunday) {
        dataSimulada = dataSimulada.add(const Duration(days: 1));
      }
      controller.onDaySelected(dataSimulada, dataSimulada);
    } catch (e) {
      debugPrint('Erro ao acionar o AgendamentoController: $e');
    }
    _proximoPasso();
  }

  // --- Encerra o tutorial e volta para a Home ---
  void _finalizarTutorial() {
    Navigator.of(context).pop();
    Get.back();
  }

  CustomClipper<Path>? _getCustomClipper() {
    switch (_passoAtual) {
      case 1:
        return HoleClipper();
      case 2:
        return SingleHoleClipper();
      case 3:
        return CalendarHoleClipper();
      case 4:
        return DateHoleClipper();
      case 5:
        return ButtonHoleClipper();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget fundoComBlur = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(color: Colors.black.withOpacity(0.4)),
    );

    final clipper = _getCustomClipper();
    if (clipper != null) {
      fundoComBlur = ClipPath(clipper: clipper, child: fundoComBlur);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _mostrarConteudo ? 1.0 : 0.0,
              child: GestureDetector(
                onTap: () {
                  // Se for o passo 2, o clique no fundo não faz nada (força clicar no botão dentista)
                  if (_passoAtual == 2) return;

                  // Direciona para a ação correta com base no passo atual
                  if (_passoAtual == 3) {
                    _avancarPasso3();
                  } else if (_passoAtual == 5) {
                    _finalizarTutorial();
                  } else {
                    _proximoPasso();
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: fundoComBlur,
              ),
            ),
          ),
          if (_mostrarConteudo) ...[
            if (_passoAtual == 0) _buildPasso0(),
            if (_passoAtual == 1) _buildPasso1(),
            if (_passoAtual == 2) _buildPasso2(),
            if (_passoAtual == 3) _buildPasso3(),
            if (_passoAtual == 4) _buildPasso4(),
            if (_passoAtual == 5) _buildPasso5(),
          ],
        ],
      ),
    );
  }

  // --- PASSO 0: BOAS VINDAS ---
  Widget _buildPasso0() {
    return Center(
      child: GestureDetector(
        onTap: _proximoPasso,
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.school, size: 50, color: Colors.purple),
              SizedBox(height: 16),
              Text(
                'Bem-vindo ao Tutorial!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Toque em qualquer lugar da tela para continuar.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- PASSO 1: BALÃO PARA TODOS OS SERVIÇOS ---
  Widget _buildPasso1() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.35,
      left: 20,
      right: 20,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -10,
            left: 50,
            child: Transform.rotate(
              angle: pi / 4,
              child: Container(width: 30, height: 30, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              'Esses são os serviços fornecidos de graça que o app trabalha, ao clicar nestes você será redirecionado para uma tela com um calendário onde poderá marcar uma data de consulta.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                height: 1.3,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- PASSO 2: SIMULAÇÃO DE CLIQUE E MUDANÇA DE TELA ---
  Widget _buildPasso2() {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.42,
          left: 10,
          right: 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -10,
                left: 50,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Container(width: 30, height: 30, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Text(
                  'Vamos testar? Toque no botão "Dentista" em destaque abaixo para ir para a tela de agendamento.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.55,
          left: 10,
          width: 130,
          height: 130,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Get.toNamed('/agendamento/dentista');

              Future.delayed(const Duration(milliseconds: 100), () {
                Get.dialog(
                  const TutorialOverlay(initialStep: 3),
                  useSafeArea: false,
                  barrierColor: Colors.transparent,
                );
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- PASSO 3: BALÃO E RECORTE DO CALENDÁRIO ---
  Widget _buildPasso3() {
    final screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.06,
          left: 20,
          right: 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -10,
                left: MediaQuery.of(context).size.width * 0.45,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Container(width: 30, height: 30, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Text(
                  'Excelente! Agora selecione o dia e o horário desejados no calendário em destaque para finalizar o seu agendamento.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.32,
          left: 15,
          width: MediaQuery.of(context).size.width - 30,
          height: 360,
          child: GestureDetector(
            onTap: _avancarPasso3, // Reutiliza a nova função extraída
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // -- PASSO 4 : INICIAR A ESCOLHA DE DATA E HORÁRIO -- //
  Widget _buildPasso4() {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.47,
          left: 20,
          right: 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -10,
                left: 50,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Container(width: 30, height: 30, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Text(
                  'Esse é o campo de data, aqui você deve escolher o horário disponível, que deseja ser atendido.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.60,
          left: 15,
          width: MediaQuery.of(context).size.width - 30,
          height: 100,
          child: GestureDetector(
            onTap: _proximoPasso,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // -- PASSO 5 : FINALIZAR (BOTÃO INFERIOR) -- //
  Widget _buildPasso5() {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.69,
          left: 20,
          right: 20,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -10,
                left: MediaQuery.of(context).size.width * 0.40,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: Container(width: 30, height: 30, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Text(
                  'Por fim, ao selecionar a data o botão ficara azul, basta tocar neste botão para concluir o agendamento da sua consulta! O app criará um compromisso no Google Calendar para te lembrar da consulta.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.86,
          left: 20,
          width: MediaQuery.of(context).size.width - 40,
          height: 100,
          child: GestureDetector(
            onTap: _finalizarTutorial,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// === CUSTOM CLIPPERS ===

class HoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final holePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(10, size.height * 0.50, size.width - 20, 370),
          const Radius.circular(16),
        ),
      );
    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class SingleHoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final holePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(10, size.height * 0.55, 130, 130),
          const Radius.circular(16),
        ),
      );
    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CalendarHoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final holePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(15, size.height * 0.15, size.width - 30, 360),
          const Radius.circular(24),
        ),
      );
    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DateHoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final holePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(15, size.height * 0.60, size.width - 30, 100),
          const Radius.circular(16),
        ),
      );
    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class ButtonHoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final holePath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(20, size.height * 0.86, size.width - 40, 100),
          const Radius.circular(12),
        ),
      );
    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
