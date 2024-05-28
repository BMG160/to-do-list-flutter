import 'package:flutter/material.dart';

class WelcomePageBloc extends ChangeNotifier{
  bool light = false;

  bool _dispose = false;

  bool get isDispose => _dispose;
  bool get getLight => light;

  void toggleLight (bool status){
    light = !light;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if(!_dispose){
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dispose = true;
  }
}