
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';
import 'package:to_do_list/network/data_agent/cloud_fire_store_database_impl.dart';
import 'package:to_do_list/network/data_agent/data_agent.dart';
import 'package:to_do_list/network/data_agent/firebase_auth_abst.dart';
import 'package:to_do_list/network/data_agent/firebase_storage_store.dart';
import 'package:to_do_list/network/data_agent/firebase_storage_store_impl.dart';

class FirebaseAuthImpl extends FirebaseAuthAbst{
  FirebaseAuthImpl._();

  static final FirebaseAuthImpl _singleton = FirebaseAuthImpl._();

  factory FirebaseAuthImpl() => _singleton;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DataAgent _agent = CloudFireStoreDatabaseImpl();
  final FirebaseStorageStore _store = FirebaseStorageStoreImpl();

  @override
  Future<void> registerNewUser(UserVO newUser) => _auth
      .createUserWithEmailAndPassword(email: newUser.email ?? '', password: newUser.password ?? '')
      .then((credential){
        User? user = credential.user;
        if(user!=null){
          user.updateDisplayName(newUser.firstName).then((_) async{
            final User? user = _auth.currentUser;
            newUser.userID = user?.uid ?? '';
            String profileURL = await _store.uploadUserProfileToFireStorage(user?.uid ?? '', File(newUser.profile ?? ''));
            _agent.createNewUser(UserVO(user?.uid ?? '', newUser.firstName, newUser.lastName, newUser.email, newUser.password, profileURL));
          });
        }
  });

  @override
  String getLoggedInUser() => _auth.currentUser?.uid ?? '';

  @override
  bool isLogin() {
    return _auth.currentUser != null;
  }

  @override
  Future logout() => _auth.signOut();

  @override
  Future userLogin(String email, String password) => _auth.signInWithEmailAndPassword(email: email, password: password);

  @override
  String getLoggedInDisplayedName() => _auth.currentUser?.displayName ?? '';

  @override
  Future deleteAccount() async{
    await _store.deleteUserProfile(_auth.currentUser?.uid ?? '');
    return _auth.currentUser!.delete();
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    await _auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
  }


}