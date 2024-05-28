
import 'dart:io';

import 'package:to_do_list/data/apply/apply.dart';
import 'package:to_do_list/data/vos/main_task_vo/main_task_vo.dart';
import 'package:to_do_list/data/vos/sub_task_vo/sub_task_vo.dart';
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';
import 'package:to_do_list/network/data_agent/cloud_fire_store_database_impl.dart';
import 'package:to_do_list/network/data_agent/data_agent.dart';
import 'package:to_do_list/network/data_agent/firebase_auth_abst.dart';
import 'package:to_do_list/network/data_agent/firebase_auth_impl.dart';
import 'package:to_do_list/network/data_agent/firebase_storage_store.dart';
import 'package:to_do_list/network/data_agent/firebase_storage_store_impl.dart';

class ApplyImpl extends Apply{
  ApplyImpl._();

  static final ApplyImpl _singleton = ApplyImpl._();

  factory ApplyImpl() => _singleton;

  final FirebaseAuthAbst _auth = FirebaseAuthImpl();
  final DataAgent _agent = CloudFireStoreDatabaseImpl();
  final FirebaseStorageStore _store = FirebaseStorageStoreImpl();

  @override
  Future<void> registerNewUser(UserVO newUser) => _auth.registerNewUser(newUser);

  @override
  String getLoggedInUser() => _auth.getLoggedInUser();

  @override
  bool isLogin() => _auth.isLogin();

  @override
  Future logout() => _auth.logout();

  @override
  Future userLogin(String email, String password) => _auth.userLogin(email, password);

  @override
  Future<void> deleteUser(String userID) => _auth.deleteAccount();

  @override
  String getLoggedInDisplayedName() => _auth.getLoggedInDisplayedName();

  @override
  Future<void> createNewMainTask(MainTaskVO newMainTask) => _agent
      .createNewMainTask(newMainTask);

  @override
  Stream<List<MainTaskVO>?> getMainTaskListByUserID(String userID) => _agent
      .getMainTaskListByUserID(userID);

  @override
  Future<UserVO?> getUserByUserID(String userID) => _agent.getUserByUserID(userID);

  @override
  Future<List<MainTaskVO>?> getMainTaskListByUserIDFuture(String userID) => _agent.getMainTaskListByUserIDFuture(userID);

  @override
  Future<void> createNewSubTask(String mainTaskID, SubTaskVO newSubTask) => _agent.createNewSubTask(mainTaskID, newSubTask);

  @override
  Future<List<SubTaskVO>?> getSubTaskListByUserIDAndMainTaskID(String userID, String mainTaskID) => _agent.getSubTaskListByUserIDAndMainTaskID(userID, mainTaskID);

  @override
  Stream<List<SubTaskVO>?> getSubTaskListByUserIDAndMainTaskIDStream(String userID, String mainTaskID) => _agent.getSubTaskListByUserIDAndMainTaskIDStream(userID, mainTaskID);

  @override
  Future<void> deleteAllMainTaskByUserID(String userID) => _agent.deleteAllMainTaskByUserID(userID);

  @override
  Future<void> deleteUserFromFirestore(String userID) => _agent.deleteUserFromFirestore(userID);

  @override
  Future<void> deleteAllSubTaskByUserID(String userID) => _agent.deleteAllSubTaskByUserID(userID);

  @override
  Future<void> deleteAllSubTaskByMainTaskID(String mainTaskID) => _agent.deleteAllSubTaskByMainTaskID(mainTaskID);

  @override
  Future<void> deleteSingleMainTaskByMainTaskID(String mainTaskID) => _agent.deleteSingleMainTaskByMainTaskID(mainTaskID);

  @override
  Future<void> deleteSingleSubTaskBySubTaskID(String subTaskID) => _agent.deleteSingleSubTaskBySubTaskID(subTaskID);

  @override
  Future<void> createNewUser(UserVO newUser, String? editImage) async {
    if(editImage == null){

      await _store.deleteUserProfile(newUser.userID);
      String profileURL = await _store.uploadUserProfileToFireStorage(newUser.userID, File(newUser.profile ?? ''));
      await _auth.updateEmail(newUser.email ?? '');
      _agent.createNewUser(UserVO(newUser.userID, newUser.firstName, newUser.lastName, newUser.email, newUser.password, profileURL));
    } else {
      await _auth.updateEmail(newUser.email ?? '');
      _agent.createNewUser(UserVO(newUser.userID, newUser.firstName, newUser.lastName, newUser.email, newUser.password, editImage));
    }
  }

}