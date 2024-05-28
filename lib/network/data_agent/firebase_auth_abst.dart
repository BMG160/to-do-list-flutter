
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';

abstract class FirebaseAuthAbst{
  Future<void> registerNewUser (UserVO newUser);

  Future userLogin (String email, String password);

  bool isLogin();

  String getLoggedInUser();

  Future logout();

  String getLoggedInDisplayedName();

  Future deleteAccount();

  Future<void> updateEmail(String newEmail);
}