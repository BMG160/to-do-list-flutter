import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_list/data/apply/apply.dart';
import 'package:to_do_list/data/apply/apply_impl.dart';
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';

import '../widgets/easy_text_widget.dart';

class RegistrationPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  File? _profileImage;

  String? editImage;

  bool _dispose = false;

  bool _passwordVisibility = true;

  final picker = ImagePicker();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isDispose => _dispose;
  File? get getProfileImage => _profileImage;
  String? get getEditImage => editImage;
  bool get getPasswordVisibility => _passwordVisibility;
  TextEditingController get getFirstNameController => firstNameController;
  TextEditingController get getLastNameController => lastNameController;
  TextEditingController get getEmailController => emailController;
  TextEditingController get getPasswordController => passwordController;

  RegistrationPageBloc(UserVO? user){
    if(user != null){
      editImage = user.profile ?? '';
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';
      emailController.text = user.email ?? '';
    }
  }

  void togglePasswordVisibility(){
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  void editUser() async{
    String userPassword = '';
    await _apply.getUserByUserID(_apply.getLoggedInUser()).then((value) {
      userPassword = value?.password ?? '';
    });
    if(_profileImage == null){
      _apply.createNewUser(UserVO(_apply.getLoggedInUser(), firstNameController.text, lastNameController.text, emailController.text, userPassword, null), editImage);
    } else {
      _apply.createNewUser(UserVO(_apply.getLoggedInUser(), firstNameController.text, lastNameController.text, emailController.text, userPassword, _profileImage?.path), null);
    }
  }
  void createNewUser(){
    _apply.registerNewUser(UserVO('', firstNameController.text, lastNameController.text, emailController.text, passwordController.text, _profileImage?.path));
  }

  Future showOptions(BuildContext context) async{
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
                onPressed: (){
                  Navigator.of(context).pop(getImageFromGallery());
                },
                child: const EasyTextWidget(text: 'Photo Gallery', textColor: Colors.black, textSize: 15, fontWeight: FontWeight.normal)
            )
          ],
        )
    );
  }

  Future getImageFromGallery() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, );
    if(pickedFile != null){
      _profileImage = File(pickedFile.path);
      notifyListeners();
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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}