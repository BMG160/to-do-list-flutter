
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';

import '../vos/main_task_vo/main_task_vo.dart';
import '../vos/sub_task_vo/sub_task_vo.dart';


abstract class Apply{
  Future<void> registerNewUser (UserVO newUser);

  Future<void> createNewUser(UserVO newUser, String? editImage);

  Future userLogin (String email, String password);

  Future<UserVO?> getUserByUserID(String userID);

  bool isLogin();

  String getLoggedInUser();

  Future logout();

  Future<void> deleteUser(String userID);

  String getLoggedInDisplayedName();

  Future<void> createNewMainTask(MainTaskVO newMainTask);

  Stream<List<MainTaskVO>?> getMainTaskListByUserID(String userID);

  Future<List<MainTaskVO>?> getMainTaskListByUserIDFuture(String userID);

  Future<void> createNewSubTask(String mainTaskID, SubTaskVO newSubTask);

  Stream<List<SubTaskVO>?> getSubTaskListByUserIDAndMainTaskIDStream(String userID, String mainTaskID);

  Future<List<SubTaskVO>?> getSubTaskListByUserIDAndMainTaskID(String userID, String mainTaskID);

  Future<void> deleteAllMainTaskByUserID(String userID);

  Future<void> deleteUserFromFirestore(String userID);

  Future<void> deleteAllSubTaskByUserID(String userID);

  Future<void> deleteAllSubTaskByMainTaskID(String mainTaskID);

  Future<void> deleteSingleMainTaskByMainTaskID(String mainTaskID);

  Future<void> deleteSingleSubTaskBySubTaskID(String subTaskID);
}