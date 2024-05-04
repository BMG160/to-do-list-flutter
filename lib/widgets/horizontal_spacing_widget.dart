import 'package:flutter/material.dart';

class HorizontalSpacingWidget extends StatelessWidget {
  final double width;
  const HorizontalSpacingWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
