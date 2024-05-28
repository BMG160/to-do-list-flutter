import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/bloc/create_sub_task_page_bloc.dart';
import 'package:to_do_list/data/vos/main_task_vo/main_task_vo.dart';
import 'package:to_do_list/data/vos/sub_task_vo/sub_task_vo.dart';
import 'package:to_do_list/widgets/easy_elevated_button_widget.dart';
import 'package:to_do_list/widgets/easy_text_form_field_widget.dart';

class CreateSubTaskPage extends StatelessWidget {
  final MainTaskVO mainTaskVO;
  final SubTaskVO? subTask;
  const CreateSubTaskPage({super.key, required this.mainTaskVO, this.subTask, });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateSubTaskPageBloc>(
      create: (_) => CreateSubTaskPageBloc(subTask),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                Image.asset('assets/welcome.png'),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.55,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text('Create New Sub-Task', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20, fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.05,
                      ),
                      Text('Sub-Task', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w300),),
                      const SizedBox(
                        height: 20,
                      ),
                      Selector<CreateSubTaskPageBloc, TextEditingController>(
                        selector: (_, bloc) => bloc.getSubTaskController,
                        builder: (_, subTaskController, child) => EasyTextFormFieldWidget(
                            hintText: 'Enter here...',
                            controller: subTaskController,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.done
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.05,
                      ),
                      (subTask == null) ? CreateNewSubTaskButtonView(mainTaskVO: mainTaskVO,) : EditSubTaskButtonView(subTask: subTask,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateNewSubTaskButtonView extends StatelessWidget {
  final MainTaskVO mainTaskVO;
  const CreateNewSubTaskButtonView({super.key, required this.mainTaskVO, });

  @override
  Widget build(BuildContext context) {
    return EasyElevatedButtonWidget(
        buttonText: 'SAVE',
        textColor: Theme.of(context).colorScheme.background,
        buttonColor: Theme.of(context).colorScheme.primary,
        onPressed: (){
          context.read<CreateSubTaskPageBloc>().createNewSubTask(context, mainTaskVO);
        },
    );
  }
}

class EditSubTaskButtonView extends StatelessWidget {
  final SubTaskVO? subTask;
  const EditSubTaskButtonView({super.key, this.subTask});

  @override
  Widget build(BuildContext context) {
    return EasyElevatedButtonWidget(
      buttonText: 'EDIT',
      textColor: Theme.of(context).colorScheme.background,
      buttonColor: Theme.of(context).colorScheme.primary,
      onPressed: (){
        context.read<CreateSubTaskPageBloc>().editTask(context, subTask?.subTaskID ?? '', subTask?.order ?? 0, subTask?.taskStatus ?? false, subTask?.mainTaskID ?? '', subTask?.userID ?? '');
      },
    );
  }
}


