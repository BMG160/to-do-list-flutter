import 'package:flutter/material.dart';

class VerticalSpacingWidget extends StatelessWidget {
  final double height;
  const VerticalSpacingWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
