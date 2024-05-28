import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/bloc/theme_bloc.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/pages/login_page.dart';
import 'package:to_do_list/pages/welcome_page.dart';
import 'package:to_do_list/theme/theme.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    ChangeNotifierProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),
      child: const MyApp(),
    )
  );
}

class DefaultFirebaseOptions {
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ThemeBloc, ThemeData>(
      selector: (_, bloc) => bloc.getThemeData,
      builder: (_, themeData, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        darkTheme: darkMode,
        routes: <String, WidgetBuilder> {
          'home' : (BuildContext context) => const HomePage(),
          'login' : (BuildContext context) => const LoginPage()
        },
        home: const WelcomePage(),
      ),
    );
  }
}

