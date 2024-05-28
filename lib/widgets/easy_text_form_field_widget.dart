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

      style: GoogleFonts.lato(textStyle: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.normal)),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.lato(textStyle: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.normal)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(10)
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon
      ),
      onTap: onTap,
    );
  }
}
