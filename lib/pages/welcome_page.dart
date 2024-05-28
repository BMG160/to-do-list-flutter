import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/bloc/welcome_page_bloc.dart';
import 'package:to_do_list/pages/login_page.dart';
import 'package:to_do_list/pages/registration_page.dart';
import 'package:to_do_list/utils/extension.dart';
import 'package:to_do_list/widgets/easy_elevated_button_widget.dart';

import '../bloc/theme_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WelcomePageBloc>(
        create: (_) => WelcomePageBloc(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          extendBodyBehindAppBar: true,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                ),
                Image.asset('assets/welcome.png'),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Welcome', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 25, fontWeight: FontWeight.w900),),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset('assets/hand_wave.png', width: 25, height: 25,)
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(child: Text('This application is developed by developer', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w200),)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(child: Text('Pyae Sone', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w600),)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const LightModeDarkModeView(),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.05,
                ),
                EasyElevatedButtonWidget(
                    buttonText: 'LOGIN',
                    textColor: Theme.of(context).colorScheme.background,
                    buttonColor: Theme.of(context).colorScheme.primary,
                    onPressed: (){
                      context.navigateToNextScreenReplace(context, const LoginPage());
                    },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('OR' , style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 15, fontWeight: FontWeight.w300),),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                EasyElevatedButtonWidget(
                    buttonText: 'REGISTER',
                    textColor: Theme.of(context).colorScheme.primary,
                    buttonColor: Theme.of(context).colorScheme.secondary,
                    onPressed: (){
                      context.navigateToNextScreenReplace(context, const RegistrationPage());
                    },
                )
              ],
            ),
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
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/sun.png', width: 40, height: 40,),
            Switch(
                value: light,
                onChanged: (bool status){
                  Provider.of<ThemeBloc>(context, listen: false).toggleTheme();
                }
            ),
            Image.asset('assets/moon.png', width: 40, height: 40,),
          ],
        ),
      ),
    );
  }
}

