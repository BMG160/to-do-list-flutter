import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/bloc/create_main_task_page_bloc.dart';
import 'package:to_do_list/widgets/easy_text_form_field_widget.dart';

import '../widgets/easy_elevated_button_widget.dart';

class CreateMainTaskPage extends StatelessWidget {
  const CreateMainTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateMainTaskPageBloc>(
      create: (_) => CreateMainTaskPageBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Image.asset('assets/welcome.png'),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('Create New Task', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20, fontWeight: FontWeight.w600),),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.05,
                    ),
                    Text('New Task', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w300),),
                    const SizedBox(
                      height: 10,
                    ),
                    Selector<CreateMainTaskPageBloc, TextEditingController>(
                      selector: (_, bloc) => bloc.getMainTaskController,
                      builder: (_, mainTaskController, child) => EasyTextFormFieldWidget(
                          hintText: 'Enter here...',
                          controller: mainTaskController,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Select Date', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w300),),
                    const SizedBox(
                      height: 10,
                    ),
                    const DateView(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Select Decoration Color', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w300),),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ColorOne(),
                        SizedBox(
                          width: 10,
                        ),
                        ColorTwo(),
                        SizedBox(
                          width: 10,
                        ),
                        ColorThree(),
                        SizedBox(
                          width: 10,
                        ),
                        ColorFour(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CreateMainTaskView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DateView extends StatelessWidget {
  const DateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CreateMainTaskPageBloc, TextEditingController>(
      selector: (_, bloc) => bloc.getDateController,
      builder: (_, dateController, child) => EasyTextFormFieldWidget(
        controller: dateController,
        textInputType: TextInputType.text,
        textInputAction: TextInputAction.done,
        readOnly: true,
        onTap: (){
          context.read<CreateMainTaskPageBloc>().setDate(context);
        },
      )
    );
  }
}


class ColorOne extends StatelessWidget {
  const ColorOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CreateMainTaskPageBloc, bool>(
      selector: (_, bloc) => bloc.isBoxOneSelected,
      builder: (_, boxOneSelected, child) => GestureDetector(
        onTap: (){
          context.read<CreateMainTaskPageBloc>().toggleBoxOne();
          context.read<CreateMainTaskPageBloc>().setSelectedColor(const Color(0xFFFFF6E7));
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: const Color(0xFFFFF6E7),
              border: (boxOneSelected) ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : Border.all(color: Theme.of(context).colorScheme.tertiary, width: 1)
          ),
        ),
      ),
    );
  }
}

class ColorTwo extends StatelessWidget {
  const ColorTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CreateMainTaskPageBloc, bool>(
      selector: (_, bloc) => bloc.isBoxTwoSelected,
      builder: (_, boxTwoSelected, child) => GestureDetector(
        onTap: (){
          context.read<CreateMainTaskPageBloc>().toggleBoxTwo();
          context.read<CreateMainTaskPageBloc>().setSelectedColor(const Color(0xFFE5FFE6));
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: const Color(0xFFE5FFE6),
              border: (boxTwoSelected) ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : Border.all(color: Theme.of(context).colorScheme.tertiary, width: 1)
          ),
        ),
      ),
    );
  }
}

class ColorThree extends StatelessWidget {
  const ColorThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CreateMainTaskPageBloc, bool>(
      selector: (_, bloc) => bloc.isBoxThreeSelected,
      builder: (_, boxThreeSelected, child) => GestureDetector(
        onTap: (){
          context.read<CreateMainTaskPageBloc>().toggleBoxThree();
          context.read<CreateMainTaskPageBloc>().setSelectedColor(const Color(0xFFF3E4F7));
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: const Color(0xFFF3E4F7),
              border: (boxThreeSelected) ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : Border.all(color: Theme.of(context).colorScheme.tertiary, width: 1)
          ),
        ),
      ),
    );
  }
}

class ColorFour extends StatelessWidget {
  const ColorFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<CreateMainTaskPageBloc, bool>(
      selector: (_, bloc) => bloc.isBoxFourSelected,
      builder: (_, boxFourSelected, child) => GestureDetector(
        onTap: (){
          context.read<CreateMainTaskPageBloc>().toggleBoxFour();
          context.read<CreateMainTaskPageBloc>().setSelectedColor(const Color(0xFFEDBBB4));
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: const Color(0xFFEDBBB4),
              border: (boxFourSelected) ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : Border.all(color: Theme.of(context).colorScheme.tertiary, width: 1)
          ),
        ),
      ),
    );
  }
}


class CreateMainTaskView extends StatelessWidget {
  const CreateMainTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyElevatedButtonWidget(
        buttonText: 'SAVE',
        textColor: Theme.of(context).colorScheme.background,
        buttonColor: Theme.of(context).colorScheme.primary,
        onPressed: (){
          context.read<CreateMainTaskPageBloc>().createMainTask(context);
        },
    );
  }
}





