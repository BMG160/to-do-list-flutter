import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/easy_text_widget.dart';

class EasyElevatedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final Color textColor;
  final Color buttonColor;
  const EasyElevatedButtonWidget({super.key, this.onPressed, required this.buttonText, required this.textColor, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(buttonColor), maximumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 40.0)), minimumSize: MaterialStatePropertyAll(Size(MediaQuery.of(context).size.width, 40.0))),
        onPressed: onPressed,
        child: EasyTextWidget(text: buttonText ?? '', textColor: textColor, textSize: 15, fontWeight: FontWeight.normal)
    );
  }
}
