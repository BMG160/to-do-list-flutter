

import 'package:flutter/material.dart';
import 'package:to_do_list/data/apply/apply.dart';
import 'package:to_do_list/data/apply/apply_impl.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/utils/extension.dart';
import 'package:to_do_list/widgets/error_snack_bar_widget.dart';
import 'package:to_do_list/widgets/loading_widget.dart';
import 'package:to_do_list/widgets/successful_snack_bar_widget.dart';

class LoginPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  bool _dispose = false;

  bool _passwordVisibility = true;

  bool isLogin = false;

  bool get isDispose => _dispose;
  bool get getPasswordVisibility => _passwordVisibility;
  bool get getIsLogin => isLogin;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  TextEditingController get getEmailController => emailController;
  TextEditingController get getPasswordController => passwordController;

  LoginPageBloc(BuildContext context){
    if(_apply.isLogin()){
      isLogin = true;
    }
    notifyListeners();
  }

  void togglePasswordVisibility(){
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  Future userLogin(BuildContext context) async{
    loadingWidget(context: context, dismiss: false);
    try{
      await _apply.userLogin(emailController.text, passwordController.text).then((value) {
        if (value != null){
          if(!context.mounted) return;
          Navigator.pop(context);
          successfulSnackBarWidget(context, 'Successfully Login.');
          context.navigateToNextScreenReplace(context, const HomePage());
        }
      });
    } catch (e) {
      if(!context.mounted) return;
      Navigator.pop(context);
      errorSnackBarWidget(context, 'Invalid Login.');
    }
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
    emailController.dispose();
    passwordController.dispose();
  }
}