import 'package:flutter/material.dart';
import 'package:to_do_list/data/apply/apply.dart';
import 'package:to_do_list/data/apply/apply_impl.dart';
import 'package:to_do_list/data/vos/main_task_vo/main_task_vo.dart';
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/utils/extension.dart';
import 'package:to_do_list/widgets/loading_widget.dart';


class CreateMainTaskPageBloc extends ChangeNotifier{
  final Apply _apply = ApplyImpl();


  bool _dispose = false;

  UserVO? loginUser;
  int? selectedColor;
  DateTime _dateTime = DateTime.now();
  bool boxOneSelected = false;
  bool boxTwoSelected = false;
  bool boxThreeSelected = false;
  bool boxFourSelected = false;

  final TextEditingController _mainTaskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool get isDispose => _dispose;
  UserVO? get getLoginUser => loginUser;
  int? get getSelectedColor => selectedColor;
  bool get isBoxOneSelected => boxOneSelected;
  bool get isBoxTwoSelected => boxTwoSelected;
  bool get isBoxThreeSelected => boxThreeSelected;
  bool get isBoxFourSelected => boxFourSelected;
  TextEditingController get getMainTaskController => _mainTaskController;
  TextEditingController get getDateController => _dateController;

  void setSelectedColor(Color color){
    selectedColor = color.value;
    notifyListeners();
  }

  CreateMainTaskPageBloc(){
    _apply.getUserByUserID(_apply.getLoggedInUser()).then((value) {
      loginUser = value;
      notifyListeners();
    });
    _dateController.text = "${_dateTime.day}/${_dateTime.month}/${_dateTime.year}";
  }

  Future<void> setDate(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2028)
    );
    if(picked!=null && picked != _dateTime){
      _dateTime = picked;
      _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      notifyListeners();
    }
  }

  void toggleBoxOne(){
    boxOneSelected = !boxOneSelected;
    boxTwoSelected = false;
    boxThreeSelected = false;
    boxFourSelected = false;
    notifyListeners();
  }

  void toggleBoxTwo(){
    boxTwoSelected = !boxTwoSelected;
    boxOneSelected = false;
    boxThreeSelected = false;
    boxFourSelected = false;
    notifyListeners();
  }

  void toggleBoxThree(){
    boxThreeSelected = !boxThreeSelected;
    boxOneSelected = false;
    boxTwoSelected = false;
    boxFourSelected = false;
    notifyListeners();
  }

  void toggleBoxFour(){
    boxFourSelected = !boxFourSelected;
    boxOneSelected = false;
    boxTwoSelected = false;
    boxThreeSelected = false;
    notifyListeners();
  }

  Future<void> createMainTask(BuildContext context) async {
    int order = 0;
    String mainTaskID = DateTime.now().millisecondsSinceEpoch.toString();
    loadingWidget(context: context, dismiss: false);
    await _apply.getMainTaskListByUserIDFuture(_apply.getLoggedInUser()).then((event) {
      if(event?.isNotEmpty ?? false){
        order = event?.last.order ?? 0;
        order = order + 1;
        _apply.createNewMainTask(MainTaskVO(mainTaskID, _mainTaskController.text, _dateController.text, selectedColor, order, _apply.getLoggedInUser()));
        notifyListeners();
      } else {
        order = 1;
        _apply.createNewMainTask(MainTaskVO(mainTaskID, _mainTaskController.text, _dateController.text, selectedColor, order, _apply.getLoggedInUser()));
        notifyListeners();
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
    _mainTaskController.dispose();
    _dateController.dispose();
  }
}