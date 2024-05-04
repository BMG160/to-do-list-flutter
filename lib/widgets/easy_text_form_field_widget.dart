import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EasyTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? hintText;
  final bool? obscureText;
  final bool? visibility;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  const EasyTextFormFieldWidget({super.key, required this.controller, required this.textInputType, required this.textInputAction, this.hintText, this.obscureText, this.visibility, this.onTap, this.suffixIcon, this.readOnly, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      readOnly: readOnly ?? false,
      keyboardType: textInputType,
      textInputAction: textInputAction,

      style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal)),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white)
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon
      ),
      onTap: onTap,
    );
  }
}
