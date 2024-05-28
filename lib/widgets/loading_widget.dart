import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/widgets/easy_text_widget.dart';

void loadingWidget({
  required BuildContext context,
  required bool dismiss,
}) {
  showDialog(
      context: context,
      barrierDismissible: dismiss,
      builder: (context) => AlertDialog(
        shadowColor: Colors.black,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Center(child: EasyTextWidget(text: 'LOADING', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.bold),),
        content: SizedBox(
          width: 100,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary
              )
            ],
          ),
        ),
      )
  );
}