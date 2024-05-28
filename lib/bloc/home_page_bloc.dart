import 'package:flutter/material.dart';
import 'package:to_do_list/data/apply/apply.dart';
import 'package:to_do_list/data/apply/apply_impl.dart';
import 'package:to_do_list/data/vos/main_task_vo/main_task_vo.dart';
import 'package:to_do_list/data/vos/sub_task_vo/sub_task_vo.dart';
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';
import 'package:to_do_list/pages/login_page.dart';
import 'package:to_do_list/pages/registration_page.dart';
import 'package:to_do_list/utils/extension.dart';
import 'package:to_do_list/widgets/loading_widget.dart';


class HomePageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  UserVO? loginUser;
  String? displayName;
  String? dateTime;

  bool _dispose = false;
  bool light = false;

  List<MainTaskVO>? mainTaskList = [];
  List<SubTaskVO>? subTaskList = [];
  Map<String, List<SubTaskVO>?> subTasks = {};
  bool get isDispose => _dispose;
  bool get getLight => light;

  UserVO? get getLoginUser => loginUser;
  String? get getDisplayName => displayName;
  String? get getDateTime => dateTime;
  List<MainTaskVO>? get getMainTaskList => mainTaskList;
  List<SubTaskVO>? get getSubTaskList => subTaskList;
  Map<String, List<SubTaskVO>?> get getSubTasks => subTasks;

  HomePageBloc(BuildContext context){
    DateTime currentDate = DateTime.now();
    dateTime = "${currentDate.day}/${currentDate.month}/${currentDate.year}";
    if(_apply.isLogin()){
      _apply.getMainTaskListByUserID(_apply.getLoggedInUser()).listen((event) {
        mainTaskList = event;
        String userID = _apply.getLoggedInUser();
        for(int i=0; i<(mainTaskList?.length ?? 0); i++){
          String mainTaskID =  mainTaskList?[i].mainTaskID ?? '';
          _apply.getSubTaskListByUserIDAndMainTaskIDStream(userID, mainTaskID).listen((event) {
            subTasks[mainTaskID] = event;
            notifyListeners();
          });
        }
        notifyListeners();
      });
      _apply.getUserByUserID(_apply.getLoggedInUser()).then((value) {
        loginUser = value;
        notifyListeners();
      });
    } else {
      context.navigateToNextScreenReplace(context, const LoginPage());
    }
  }

  void deleteAll(BuildContext context) async{
    loadingWidget(context: context, dismiss: false);
    String userID = _apply.getLoggedInUser();
    await _apply.deleteAllMainTaskByUserID(userID);
    await _apply.deleteAllSubTaskByUserID(userID);
    await _apply.deleteUserFromFirestore(userID);
    await _apply.deleteUser(userID);
    if(!context.mounted) return;
    Navigator.pop(context);
    context.navigateToNextScreenReplace(context, const LoginPage());
  }

  void deleteSingleMainTask(String mainTaskID) async{
    await _apply.deleteSingleMainTaskByMainTaskID(mainTaskID);
    await _apply.deleteAllSubTaskByMainTaskID(mainTaskID);
    _apply.getMainTaskListByUserID(_apply.getLoggedInUser()).listen((event) {
      mainTaskList = event;
      String userID = _apply.getLoggedInUser();
      for(int i=0; i<(mainTaskList?.length ?? 0); i++){
        _apply.getSubTaskListByUserIDAndMainTaskIDStream(userID, mainTaskList?[i].mainTaskID ?? '').listen((event) {
          subTasks[mainTaskList?[i].mainTaskID ?? ''] = event;
        });
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void toggleTaskStatus(BuildContext context, SubTaskVO subTask) async{
    bool newStatus = !(subTask.taskStatus ?? false);
    _apply.createNewSubTask(subTask.mainTaskID ?? '', SubTaskVO(subTask.subTaskID, subTask.subTask, subTask.order, newStatus, subTask.mainTaskID, subTask.userID));
    _apply.getMainTaskListByUserID(_apply.getLoggedInUser()).listen((event) {
      mainTaskList = event;
      String userID = _apply.getLoggedInUser();
      for(int i=0; i<(mainTaskList?.length ?? 0); i++){
        _apply.getSubTaskListByUserIDAndMainTaskIDStream(userID, mainTaskList?[i].mainTaskID ?? '').listen((event) {
          subTasks[mainTaskList?[i].mainTaskID ?? ''] = event;
        });
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void deleteSingleSubTask(String subTaskID){
    _apply.deleteSingleSubTaskBySubTaskID(subTaskID);
    _apply.getMainTaskListByUserID(_apply.getLoggedInUser()).listen((event) {
      mainTaskList = event;
      String userID = _apply.getLoggedInUser();
      for(int i=0; i<(mainTaskList?.length ?? 0); i++){
        _apply.getSubTaskListByUserIDAndMainTaskIDStream(userID, mainTaskList?[i].mainTaskID ?? '').listen((event) {
          subTasks[mainTaskList?[i].mainTaskID ?? ''] = event;
        });
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void navigateToEditPage(BuildContext context)async{
    UserVO? user = await _apply.getUserByUserID(_apply.getLoggedInUser());
    if(!context.mounted) return;
    context.navigateToNextScreenReplace(context, RegistrationPage(user: user,));
  }

  void signOut(BuildContext context) async{
    loadingWidget(context: context, dismiss: false);
    await _apply.logout();
    if(!context.mounted) return;
    Navigator.popUntil(context, ModalRoute.withName('login'));
    context.navigateToNextScreenReplace(context, const LoginPage());
  }

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