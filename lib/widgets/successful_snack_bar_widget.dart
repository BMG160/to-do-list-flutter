import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/easy_text_widget.dart';

void successfulSnackBarWidget(BuildContext context, String feedbackMessage){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.all(20),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EasyTextWidget(text: feedbackMessage, textColor: Colors.white, textSize: 15, fontWeight: FontWeight.bold)
          ],
        ),
      ),
    )
  );
}