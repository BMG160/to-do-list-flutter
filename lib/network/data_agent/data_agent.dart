
import 'package:to_do_list/data/vos/main_task_vo/main_task_vo.dart';
import 'package:to_do_list/data/vos/sub_task_vo/sub_task_vo.dart';
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';


abstract class DataAgent{
  Future<void> createNewUser(UserVO newUser);

  Future<UserVO?> getUserByUserID(String userID);

  Future<void> createNewMainTask(MainTaskVO newMainTask);

  Stream<List<MainTaskVO>?> getMainTaskListByUserID(String userID);

  Future<List<MainTaskVO>?> getMainTaskListByUserIDFuture(String userID);

  Future<void> createNewSubTask(String mainTaskID, SubTaskVO newSubTask);

  Stream<List<SubTaskVO>?> getSubTaskListByUserIDAndMainTaskIDStream(String userID, String mainTaskID);

  Future<List<SubTaskVO>?> getSubTaskListByUserIDAndMainTaskID(String userID, String mainTaskID);

  Future<void> deleteAllSubTaskByUserID(String userID);

  Future<void> deleteAllMainTaskByUserID(String userID);

  Future<void> deleteUserFromFirestore(String userID);

  Future<void> deleteAllSubTaskByMainTaskID(String mainTaskID);

  Future<void> deleteSingleMainTaskByMainTaskID(String mainTaskID);

  Future<void> deleteSingleSubTaskBySubTaskID(String subTaskID);
}