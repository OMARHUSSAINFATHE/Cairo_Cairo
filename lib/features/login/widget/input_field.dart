import 'package:flutter/material.dart';


// ─── _InputField ──────────────────────────────────────────────────────────────

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscure;
  final double sw;

  const InputField({
    required this.controller,
    required this.sw,
    this.prefixIcon,
    this.suffixIcon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      textDirection: TextDirection.ltr,
      style: TextStyle(fontSize: sw * 0.038, color: const Color(0xFF1A1A1A)),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: sw * 0.04,
          vertical: sw * 0.038,
        ),
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFFC107), width: 1.5),
        ),
      ),
    );
  }
}
