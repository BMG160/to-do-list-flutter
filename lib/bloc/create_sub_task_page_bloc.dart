import 'package:flutter/material.dart';
import 'package:to_do_list/data/apply/apply.dart';
import 'package:to_do_list/data/apply/apply_impl.dart';
import 'package:to_do_list/data/vos/main_task_vo/main_task_vo.dart';
import 'package:to_do_list/data/vos/sub_task_vo/sub_task_vo.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/utils/extension.dart';
import 'package:to_do_list/widgets/loading_widget.dart';

class CreateSubTaskPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();

  final TextEditingController _subTaskController = TextEditingController();

  bool _dispose = false;

  bool taskStatus = false;

  bool get isDispose => _dispose;
  TextEditingController get getSubTaskController => _subTaskController;

  CreateSubTaskPageBloc(SubTaskVO? subTaskVO){
    if(subTaskVO != null){
      _subTaskController.text = subTaskVO.subTask ?? '';
    }
  }

  void editTask(BuildContext context, String subTaskID, int order, bool taskStatus, String mainTaskID, String userID) async{
    loadingWidget(context: context, dismiss: false);
    await _apply.createNewSubTask(mainTaskID, SubTaskVO(subTaskID, _subTaskController.text, order, taskStatus, mainTaskID, userID));
    if(!context.mounted) return;
    Navigator.pop(context);
    Navigator.popUntil(context, ModalRoute.withName('home'));
    context.navigateToNextScreenReplace(context, const HomePage());
  }

  void setTaskStatus(String subTaskID, String subTask,int order, String mainTaskID, String userID){
    taskStatus = true;
    _apply.createNewSubTask(mainTaskID, SubTaskVO(subTaskID, subTask, order, taskStatus, mainTaskID, userID));
    taskStatus = false;
    notifyListeners();
  }

  Future<void> createNewSubTask(BuildContext context, MainTaskVO mainTaskVO) async{
    int order = 0;
    String userID = _apply.getLoggedInUser();
    loadingWidget(context: context, dismiss: false);
    await _apply.getSubTaskListByUserIDAndMainTaskID(_apply.getLoggedInUser(), mainTaskVO.mainTaskID ?? '').then((value) async {
      if(value?.isNotEmpty ?? false || value != null){
        order = value?.last.order ?? 0;
        order++;
        await _apply.createNewSubTask(mainTaskVO.mainTaskID ?? '', SubTaskVO(DateTime.now().millisecondsSinceEpoch.toString(), _subTaskController.text, order, taskStatus, mainTaskVO.mainTaskID ?? '', userID));
        notifyListeners();
      } else{
        order = 1;
        await _apply.createNewSubTask(mainTaskVO.mainTaskID ?? '', SubTaskVO(DateTime.now().millisecondsSinceEpoch.toString(), _subTaskController.text, order, taskStatus, mainTaskVO.mainTaskID ?? '', userID));
      }
    });
    if(!context.mounted) return;
    Navigator.pop(context);
    context.navigateToNextScreenReplace(context, const HomePage());
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
    _subTaskController.dispose();
  }
}