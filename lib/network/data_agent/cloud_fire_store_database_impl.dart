

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/constant/strings.dart';
import 'package:to_do_list/data/vos/main_task_vo/main_task_vo.dart';
import 'package:to_do_list/data/vos/sub_task_vo/sub_task_vo.dart';
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';
import 'package:to_do_list/network/data_agent/data_agent.dart';

class CloudFireStoreDatabaseImpl extends DataAgent{
  CloudFireStoreDatabaseImpl._();

  static final CloudFireStoreDatabaseImpl _singleton = CloudFireStoreDatabaseImpl._();

  factory CloudFireStoreDatabaseImpl() => _singleton;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future<void> createNewUser(UserVO newUser) {
    return _firestore
        .collection(kRootNodeForUser)
        .doc(newUser.userID)
        .set(newUser.toJson());
  }

  @override
  Future<void> createNewMainTask(MainTaskVO newMainTask) => _firestore
      .collection(kRootNodeForMainTask)
      .doc(newMainTask.mainTaskID)
      .set(newMainTask.toJson());

  @override
  Stream<List<MainTaskVO>?> getMainTaskListByUserID(String userID) => _firestore
      .collection(kRootNodeForMainTask)
      .where('user_id', isEqualTo: userID)
      .snapshots()
      .map((querySnapShot){
        return querySnapShot.docs.map((document){
          return MainTaskVO.fromJson(document.data());
        }).toList();
  });

  @override
  Future<UserVO?> getUserByUserID(String userID) => _firestore
      .collection(kRootNodeForUser)
      .doc(userID)
      .get()
      .asStream()
      .map((documentSnapShot) => UserVO.fromJson(documentSnapShot.data() ?? {})).first;

  @override
  Future<List<MainTaskVO>?> getMainTaskListByUserIDFuture(String userID) => _firestore
      .collection(kRootNodeForMainTask)
      .where('user_id', isEqualTo: userID)
      .get()
      .asStream()
      .map((querySnapshot){
        return querySnapshot.docs.map((document){
          return MainTaskVO.fromJson(document.data());
        }).toList();
  }).first;

  @override
  Future<void> createNewSubTask(String mainTaskID,SubTaskVO newSubTask) => _firestore
      .collection(kRootNodeForSubTask)
      .doc(newSubTask.subTaskID.toString())
      .set(newSubTask.toJson());

  @override
  Future<List<SubTaskVO>?> getSubTaskListByUserIDAndMainTaskID(String userID, String mainTaskID) => _firestore
      .collection(kRootNodeForSubTask)
      .where('user_id', isEqualTo: userID)
      .where('main_task_id', isEqualTo: mainTaskID)
      .get()
      .asStream()
      .map((querySnapshot) {
        return querySnapshot.docs.map((document){
          return SubTaskVO.fromJson(document.data());
        }).toList();
  }).first;

  @override
  Stream<List<SubTaskVO>?> getSubTaskListByUserIDAndMainTaskIDStream(String userID, String mainTaskID) => _firestore
      .collection(kRootNodeForSubTask)
      .where('user_id', isEqualTo: userID)
      .where('main_task_id', isEqualTo: mainTaskID)
      .snapshots()
      .map((querySnapshot){
        return querySnapshot.docs.map((document){
          return SubTaskVO.fromJson(document.data());
        }).toList();
  });

  @override
  Future<void> deleteAllMainTaskByUserID(String userID) => _firestore
      .collection(kRootNodeForMainTask)
      .where('user_id', isEqualTo: userID)
      .get()
      .asStream()
      .map((querySnapSnot){
        for (var element in querySnapSnot.docs) {
          _firestore.collection(kRootNodeForMainTask).doc(element.id).delete();
        }
  }).first;

  @override
  Future<void> deleteAllSubTaskByUserID(String userID) => _firestore
      .collection(kRootNodeForSubTask)
      .where('user_id', isEqualTo: userID)
      .get()
      .asStream()
      .map((querySnapSnot){
    for (var element in querySnapSnot.docs) {
      print(element.id);
          _firestore.collection(kRootNodeForSubTask).doc(element.id).delete();
    }
  }).first;

  @override
  Future<void> deleteUserFromFirestore(String userID) => _firestore
      .collection(kRootNodeForUser)
      .doc(userID)
      .delete();

  @override
  Future<void> deleteAllSubTaskByMainTaskID(String mainTaskID) => _firestore
      .collection(kRootNodeForSubTask)
      .where('main_task_id', isEqualTo: mainTaskID)
      .get()
      .asStream()
      .map((querySnapShot){
        for(var element in querySnapShot.docs){
          _firestore.collection(kRootNodeForSubTask).doc(element.id).delete();
        }
  }).first;

  @override
  Future<void> deleteSingleMainTaskByMainTaskID(String mainTaskID) => _firestore
      .collection(kRootNodeForMainTask)
      .doc(mainTaskID)
      .delete();

  @override
  Future<void> deleteSingleSubTaskBySubTaskID(String subTaskID) => _firestore
      .collection(kRootNodeForSubTask)
      .doc(subTaskID)
      .delete();

}