import 'package:flutter/material.dart';

import 'easy_text_widget.dart';

void errorSnackBarWidget(BuildContext context, String errorMessage){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(20),
          width: 150,
          height: 80,
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EasyTextWidget(text: errorMessage, textColor: Colors.white, textSize: 15, fontWeight: FontWeight.bold)
            ],
          ),
        ),
      )
  );
}