import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/bloc/registration_page_bloc.dart';
import 'package:to_do_list/data/vos/user_vo/user_vo.dart';
import 'package:to_do_list/pages/login_page.dart';
import 'package:to_do_list/utils/extension.dart';

import '../widgets/easy_elevated_button_widget.dart';
import '../widgets/easy_text_form_field_widget.dart';
import '../widgets/easy_text_widget.dart';
import '../widgets/horizontal_spacing_widget.dart';
import '../widgets/vertical_spacing_widget.dart';

class RegistrationPage extends StatelessWidget {
  final UserVO? user;
  const RegistrationPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegistrationPageBloc>(
        create: (_) => RegistrationPageBloc(user),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                  ),
                  (user == null) ?
                  Center(
                    child: EasyTextWidget(text: 'REGISTRATION', textColor: Theme.of(context).colorScheme.primary, textSize: 25, fontWeight: FontWeight.bold),
                  ) : Center(
                    child: EasyTextWidget(text: 'EDIT ACCOUNT', textColor: Theme.of(context).colorScheme.primary, textSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  (user == null) ? ProfileView(profile: user?.profile ?? '',) : EditProfileView(user: user,),
                  const VerticalSpacingWidget(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EasyTextWidget(text: 'First Name:', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.bold),
                          const VerticalSpacingWidget(height: 10),
                          Selector<RegistrationPageBloc, TextEditingController>(
                            selector: (_, bloc) => bloc.getFirstNameController,
                            builder: (_, firstNameController, child) => SizedBox(
                              width: MediaQuery.of(context).size.width*0.42,
                              child: EasyTextFormFieldWidget(controller: firstNameController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'First Name', prefixIcon: Icon(Icons.person, color: Theme.of(context).colorScheme.primary,),),
                            ),
                          ),
                        ],
                      ),
                      const HorizontalSpacingWidget(width: 20),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EasyTextWidget(text: 'Last Name:', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.bold),
                          const VerticalSpacingWidget(height: 10),
                          Selector<RegistrationPageBloc, TextEditingController>(
                            selector: (_, bloc) => bloc.getLastNameController,
                            builder: (_, lastNameController, child) => SizedBox(
                              width: MediaQuery.of(context).size.width*0.42,
                              child: EasyTextFormFieldWidget(controller: lastNameController, textInputType: TextInputType.text, textInputAction: TextInputAction.next, hintText: 'Last Name', prefixIcon: Icon(Icons.person, color: Theme.of(context).colorScheme.primary,),),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const VerticalSpacingWidget(height: 20),
                  EasyTextWidget(text: 'Email:', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.bold),
                  const VerticalSpacingWidget(height: 10),
                  Selector<RegistrationPageBloc, TextEditingController>(
                    selector: (_, bloc) => bloc.getEmailController,
                    builder: (_, emailController, child) => EasyTextFormFieldWidget(controller: emailController, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next, hintText: 'Enter your email address here.', prefixIcon:  Icon(Icons.email, color: Theme.of(context).colorScheme.primary,),),
                  ),
                  const VerticalSpacingWidget(height: 20),
                  (user == null)? EasyTextWidget(text: 'Password:', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.bold) : const SizedBox(),
                  const VerticalSpacingWidget(height: 10),
                  (user == null) ?
                  Selector<RegistrationPageBloc, TextEditingController>(
                    selector: (_, bloc) => bloc.getPasswordController,
                    builder: (_, passwordController, child) => Selector<RegistrationPageBloc, bool>(
                      selector: (_, bloc) => bloc.getPasswordVisibility,
                      builder: (_, passwordVisibility, child) => EasyTextFormFieldWidget(obscureText: passwordVisibility, controller: passwordController, textInputType: TextInputType.visiblePassword, textInputAction: TextInputAction.done, hintText: 'Enter your password here.', prefixIcon: Icon(Icons.lock, color: Theme.of(context).colorScheme.primary,), suffixIcon: PasswordVisibilityButtonView(passwordVisibility: passwordVisibility),),
                    ),
                  ) : const SizedBox(),
                  const VerticalSpacingWidget(height: 30),
                  (user == null) ?
                  const RegisterButtonView() :
                  const EditUserAccountButtonView(),
                  const VerticalSpacingWidget(height: 20),
                  (user == null) ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EasyTextWidget(text: 'Already have an account?', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.normal),
                      const HorizontalSpacingWidget(width: 10),
                      GestureDetector(
                        onTap: (){
                          context.navigateToNextScreenReplace(context, const LoginPage());
                        },
                        child: EasyTextWidget(text: 'LOGIN HERE', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                      )
                    ],
                  ) : const SizedBox()
                ],
              ),
            ),
          ),
        ),
    );
  }
}
class ProfileView extends StatelessWidget {
  final String? profile;
  const ProfileView({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Selector<RegistrationPageBloc, File?>(
      selector: (_, bloc) => bloc.getProfileImage,
      builder: (_, profileImage, child) => Center(
        child: GestureDetector(
          onTap: (){
            context.read<RegistrationPageBloc>().showOptions(context);
          },
          child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle
              ),
              child: ClipOval(
                child: (profileImage == null) ? Icon(Icons.person, size: 50, color: Theme.of(context).colorScheme.background,) : Image.file(profileImage, fit: BoxFit.cover,),
              )
          ),
        ),
      ),
    );
  }
}

class EditProfileView extends StatelessWidget {
  final UserVO? user;
  const EditProfileView({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Selector<RegistrationPageBloc, String?>(
      selector: (_, bloc) => bloc.getEditImage,
      builder: (_, editImage, child) => Selector<RegistrationPageBloc, File?>(
        selector: (_, bloc) => bloc.getProfileImage,
        builder: (_, profileImage, child) => Center(
          child: GestureDetector(
            onTap: (){
              context.read<RegistrationPageBloc>().showOptions(context);
            },
            child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle
                ),
                child: ClipOval(
                  child: (profileImage == null) ? Image.network(editImage ?? '', fit: BoxFit.cover,) : Image.file(profileImage, fit: BoxFit.cover,),
                )
            ),
          ),
        ),
      ),
    );
  }
}



class RegisterButtonView extends StatelessWidget {
  const RegisterButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyElevatedButtonWidget(
        onPressed: (){
          context.read<RegistrationPageBloc>().createNewUser();
        },
        buttonText: 'REGISTER',
        textColor: Theme.of(context).colorScheme.background,
        buttonColor: Theme.of(context).colorScheme.primary
    );
  }
}

class PasswordVisibilityButtonView extends StatelessWidget {
  final bool passwordVisibility;
  const PasswordVisibilityButtonView({super.key, required this.passwordVisibility});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.read<RegistrationPageBloc>().togglePasswordVisibility();
        },
        icon: Icon(
          (passwordVisibility) ? Icons.visibility: Icons.visibility_off,
          color: Theme.of(context).colorScheme.primary,
        )
    );
  }
}

class EditUserAccountButtonView extends StatelessWidget {
  final UserVO? user;
  const EditUserAccountButtonView({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return EasyElevatedButtonWidget(
        onPressed: (){
          context.read<RegistrationPageBloc>().editUser();
        },
        buttonText: 'EDIT',
        textColor: Theme.of(context).colorScheme.background,
        buttonColor: Theme.of(context).colorScheme.primary
    );
  }
}


