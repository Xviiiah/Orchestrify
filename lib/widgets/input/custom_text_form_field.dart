import 'package:flutter/material.dart';
import 'package:forti_grad/constants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.size,
    required this.width,
    required this.textEditingController,
    this.label,
    this.obscure = false,
    this.hint,
    this.validator,
    this.enabled = true,
  });

  final Size size;
  final double width;
  final bool obscure;
  final String? hint;
  final String? label;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kSecondaryColor, borderRadius: BorderRadius.circular(8)),
      width: size.width * width,
      child: TextFormField(
        enabled: enabled,
        style: const TextStyle(color: Colors.white), // Set your desired color
        controller: textEditingController,
        obscureText: obscure,
        validator: validator,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          labelStyle: const TextStyle(color: Colors.white),
          label: label != null ? Text(label!) : null,
          hintText: hint,
          border: const OutlineInputBorder(
            borderSide: BorderSide(width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
