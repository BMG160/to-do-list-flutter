import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/bloc/home_page_bloc.dart';
import 'package:to_do_list/constant/dimens.dart';
import 'package:to_do_list/constant/strings.dart';
import 'package:to_do_list/data/vos/main_task_vo/main_task_vo.dart';
import 'package:to_do_list/data/vos/sub_task_vo/sub_task_vo.dart';
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';
import 'package:to_do_list/pages/create_main_task_page.dart';
import 'package:to_do_list/pages/create_sub_task_page.dart';
import 'package:to_do_list/utils/extension.dart';
import 'package:to_do_list/widgets/easy_elevated_button_widget.dart';
import 'package:to_do_list/widgets/easy_text_widget.dart';
import 'package:to_do_list/widgets/horizontal_spacing_widget.dart';
import 'package:to_do_list/widgets/vertical_spacing_widget.dart';

import '../bloc/theme_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageBloc>(
      create: (_) => HomePageBloc(context),
      child: Selector<HomePageBloc, UserVO?>(
        selector: (_, bloc) => bloc.getLoginUser,
        builder: (_, loginUser, child) => Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            flexibleSpace: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent,),
            ),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text('TO DO', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 25, fontWeight: FontWeight.w900),),
            leading: Builder(
                builder: (context) => IconButton(
                    onPressed: (){
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Theme.of(context).colorScheme.primary,
                      size: 25,
                    )
                )
            ),
            actions: const [
              LogOutButtonView(),
              HorizontalSpacingWidget(width: k15px)
            ],
          ),
          body: Selector<HomePageBloc, List<MainTaskVO>?>(
              selector: (_, bloc) => bloc.getMainTaskList,
              builder: (_, mainTaskList, child) => (mainTaskList?.isEmpty ?? false) ?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/empty_box.png', width: k100px, height: k100px,),
                    const VerticalSpacingWidget(height: k20px),
                    EasyTextWidget(text: kThereIsNoData, textColor: Theme.of(context).colorScheme.primary, textSize: k20px, fontWeight: FontWeight.bold),
                  ],
                ),
              ) :
              Selector<HomePageBloc, String?>(
                selector: (_, bloc) => bloc.getDateTime,
                builder: (_, dateTime, child) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Hello, ${loginUser?.firstName}${loginUser?.lastName}", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 30, fontWeight: FontWeight.w600),),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset('assets/hand_wave.png', width: 30, height: 30,)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("${dateTime ?? ''}(Today)", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w200),)
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, mainIndex) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(mainTaskList?[mainIndex].color ?? 0),
                                  border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                                  borderRadius: const BorderRadius.all(Radius.circular(20))
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(mainTaskList?[mainIndex].task ?? '', style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
                                        IconButton(
                                            onPressed: (){
                                              context.read<HomePageBloc>().deleteSingleMainTask(mainTaskList?[mainIndex].mainTaskID ?? '');
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.black,
                                              size: 25,
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(mainTaskList?[mainIndex].date ?? '', style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w200),)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Selector<HomePageBloc, Map<String, List<SubTaskVO>?>>(
                                        selector: (_, bloc) => bloc.getSubTasks,
                                        builder: (_, subTasks, child) {
                                          List<SubTaskVO>? subTaskList = subTasks[mainTaskList?[mainIndex].mainTaskID ?? ''];
                                                return (subTaskList?.isEmpty ?? false) ? const Center(child: Text('There is no data.', style: TextStyle(color: Colors.black),),) : ListView.separated(
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder: (context, index) => Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      context.read<HomePageBloc>().toggleTaskStatus(context, subTaskList![index] );
                                                    },
                                                    child: AnimatedSwitcher(
                                                      duration: const Duration(milliseconds: 500),
                                                      child: (subTaskList?[index].taskStatus == false) ?
                                                      Icon(
                                                        Icons.check_box_outline_blank,
                                                        color: Colors.black,
                                                        size: 25,
                                                        key: UniqueKey(),
                                                      ) : Icon(
                                                        Icons.check_box_outlined,
                                                        color: Colors.black,
                                                        size: 25,
                                                        key: UniqueKey(),
                                                      ),
                                                    ) ,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  AnimatedSwitcher(
                                                    duration: const Duration(milliseconds: 500),
                                                    child: (subTaskList?[index].taskStatus ?? false) ?
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width*0.6,
                                                      child: Text(subTaskList?[index].subTask ?? '', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black, decorationColor: Colors.black), key: ValueKey(subTaskList?[index].subTask ?? ''),),
                                                    ) :
                                                    SizedBox(
                                                      width: MediaQuery.of(context).size.width*0.6,
                                                      child: Text(subTaskList?[index].subTask ?? '', style: const TextStyle(decoration: TextDecoration.none, color: Colors.black), key: ValueKey(subTaskList?[index].subTask ?? ''),),
                                                    )
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){
                                                      context.navigateToNextScreenReplace(context, CreateSubTaskPage(mainTaskVO: mainTaskList![mainIndex], subTask: subTaskList![index],));
                                                    },
                                                    child: const Icon(
                                                      Icons.edit,
                                                      color: Colors.black,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){
                                                      context.read<HomePageBloc>().deleteSingleSubTask(subTaskList?[index].subTaskID ?? '');
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Colors.black,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              separatorBuilder: (context, index) => const SizedBox(
                                                height: 10,
                                              ),
                                              itemCount: subTaskList?.length ?? 0
                                          );
                                        }
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AddNewSubTaskButtonView(mainTaskVO: mainTaskList![mainIndex] ,)
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 10,),
                          itemCount: mainTaskList?.length ?? 0
                      )
                    ],
                  ),
                ),
              )
          ),
          drawer: Drawer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: (loginUser?.profile == null) ?
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ) : ClipOval(
                          child: Image.network(loginUser?.profile ?? '', fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress){
                            if(loadingProgress == null){
                              return child;
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              );
                            }
                          },),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("${loginUser?.firstName}${loginUser?.lastName}", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20, fontWeight: FontWeight.w600),)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                const LightModeDarkModeView(),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                const EditAccountView(),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 20,
                ),
                const AccountDeleteButtonView()
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: (){
                context.navigateToNextScreenReplace(context, const CreateMainTaskPage());
              },
              child: Icon(
                Icons.add,
                size: 20,
                color: Theme.of(context).colorScheme.background,
              ),
          ),
        ),
      ),
    );
  }
}

class AccountDeleteButtonView extends StatelessWidget {
  const AccountDeleteButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: EasyElevatedButtonWidget(
          buttonText: 'DELETE ACCOUNT',
          textColor: Colors.white,
          buttonColor: Colors.red,
          onPressed: (){
            context.read<HomePageBloc>().deleteAll(context);
          },
        ),
      ),
    );
  }
}

class LightModeDarkModeView extends StatelessWidget {
  const LightModeDarkModeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeBloc, bool>(
      selector: (_, bloc) => bloc.getLight,
      builder: (_, light, child) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/sun.png', width: 30, height: 30,),
            Switch(
                value: light,
                onChanged: (bool status){
                  Provider.of<ThemeBloc>(context, listen: false).toggleTheme();
                }
            ),
            Image.asset('assets/moon.png', width: 30, height: 30,),
          ],
        ),
      ),
    );
  }
}


class AddNewSubTaskButtonView extends StatelessWidget {
  final MainTaskVO mainTaskVO;
  const AddNewSubTaskButtonView({super.key, required this.mainTaskVO});

  @override
  Widget build(BuildContext context) {
    return EasyElevatedButtonWidget(
        buttonText: 'Add New Task',
        textColor: Colors.white,
        buttonColor: Colors.black,
        onPressed: (){
          context.navigateToNextScreenReplace(context, CreateSubTaskPage(mainTaskVO: mainTaskVO,));
        },
    );
  }
}


class LogOutButtonView extends StatelessWidget {
  const LogOutButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        context.read<HomePageBloc>().signOut(context);
      },
      icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.primary, size: k30px,),
    );
  }
}

class EditAccountView extends StatelessWidget {
  const EditAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Edit Account'),
      onTap: (){
        context.read<HomePageBloc>().navigateToEditPage(context);
      },
    );
  }
}

class SubTaskView extends StatefulWidget {
  final String subTask;
  const SubTaskView({super.key, required this.subTask});

  @override
  State<SubTaskView> createState() => _SubTaskViewState();
}

class _SubTaskViewState extends State<SubTaskView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



