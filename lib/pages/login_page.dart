import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/bloc/login_page_bloc.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/pages/registration_page.dart';
import 'package:to_do_list/utils/extension.dart';

import 'package:to_do_list/widgets/easy_elevated_button_widget.dart';
import 'package:to_do_list/widgets/easy_text_form_field_widget.dart';
import 'package:to_do_list/widgets/easy_text_widget.dart';
import 'package:to_do_list/widgets/horizontal_spacing_widget.dart';
import 'package:to_do_list/widgets/vertical_spacing_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageBloc>(
        create: (_) => LoginPageBloc(context),
        child: Selector<LoginPageBloc, bool>(
          selector: (_, bloc) => bloc.getIsLogin,
          builder: (_, isLogin, child) => Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: (isLogin) ? const HomePage() : SingleChildScrollView(
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
                      Image.asset('assets/welcome.png'),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: EasyTextWidget(text: 'LOGIN', textColor: Theme.of(context).colorScheme.primary, textSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const VerticalSpacingWidget(height: 20),
                      EasyTextWidget(text: 'Email:', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.bold),
                      const VerticalSpacingWidget(height: 10),
                      Selector<LoginPageBloc, TextEditingController>(
                        selector: (_, bloc) => bloc.getEmailController,
                        builder: (_, emailController, child) => EasyTextFormFieldWidget(controller: emailController, textInputType: TextInputType.emailAddress, textInputAction: TextInputAction.next, hintText: 'Enter your email address here.', prefixIcon: Icon(Icons.email, color: Theme.of(context).colorScheme.primary,),),
                      ),
                      const VerticalSpacingWidget(height: 20),
                      EasyTextWidget(text: 'Password:', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.bold),
                      const VerticalSpacingWidget(height: 10),
                      Selector<LoginPageBloc, TextEditingController>(
                        selector: (_, bloc) => bloc.getPasswordController,
                        builder: (_, passwordController, child) => Selector<LoginPageBloc, bool>(
                          selector: (_, bloc) => bloc.getPasswordVisibility,
                          builder: (_, passwordVisibility, child) => EasyTextFormFieldWidget(obscureText: passwordVisibility, controller: passwordController, textInputType: TextInputType.visiblePassword, textInputAction: TextInputAction.done, hintText: 'Enter your password here.', prefixIcon: Icon(Icons.lock, color: Theme.of(context).colorScheme.primary,), suffixIcon: PasswordVisibilityButtonView(passwordVisibility: passwordVisibility),),
                        ),
                      ),
                      const VerticalSpacingWidget(height: 30),
                      const LoginButtonView(),
                      const VerticalSpacingWidget(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EasyTextWidget(text: 'Register new account?', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.normal),
                          const HorizontalSpacingWidget(width: 10),
                          GestureDetector(
                            onTap: (){
                              context.navigateToNextScreenReplace(context, const RegistrationPage(user: null,));
                            },
                            child: EasyTextWidget(text: 'CLICK HERE', textColor: Theme.of(context).colorScheme.primary, textSize: 15, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
          ),
        ),
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
          context.read<LoginPageBloc>().togglePasswordVisibility();
        },
        icon: Icon(
            (passwordVisibility) ? Icons.visibility: Icons.visibility_off,
            color: Theme.of(context).colorScheme.primary,
        )
    );
  }
}


class LoginButtonView extends StatelessWidget {
  const LoginButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyElevatedButtonWidget(
      buttonText: 'LOGIN',
      textColor: Theme.of(context).colorScheme.background,
      buttonColor: Theme.of(context).colorScheme.primary,
      onPressed: (){
        context.read<LoginPageBloc>().userLogin(context);
      },
    );
  }
}

