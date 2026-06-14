import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:una_agendamento/app/modules/login/login_controller.dart';

//Construção do Widget do Campo de Email
class EmailField extends GetView<LoginController> {
  final bool isDark;
  const EmailField({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.only(left: 8, right: 8),
      child: Obx(() => TextField(
        controller: controller.emailInput,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: isDark ? const Color(0xFFFFFFFF) : Colors.black87,
        ),
        cursorColor: isDark ? const Color(0xFFB05CFF) : Colors.black87,
        decoration: InputDecoration(
          label: Text(
            "EMAIL",
            style: TextStyle(
              color: isDark ? const Color(0xFFBDBDBD) : Colors.black87,
            ),
          ),
          errorText: controller.errorEmail.value,
          filled: true,
          fillColor: isDark ? const Color(0xFF262626) : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: isDark ? const Color(0xFF333333) : Colors.grey[300]!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: isDark ? const Color(0xFF333333) : Colors.grey[300]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFFB05CFF),
              width: 2,
            ),
          ),
        ),
      )),
    );
  }
}