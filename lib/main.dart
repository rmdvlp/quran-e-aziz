
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_aziz/blocs/home_bloc/home_bloc.dart';
import 'package:quran_aziz/blocs/login_bloc/login_bloc.dart';
import 'package:quran_aziz/blocs/signup_bloc/signUp_bloc.dart';
import 'package:quran_aziz/screens/introduction_screen.dart';
import 'package:quran_aziz/screens/splash_Screen.dart';
import 'package:quran_aziz/utils/apptheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? seen = prefs.getBool('seenIntro');
  runApp( MyApp(seenIntro: seen,));
}

class MyApp extends StatelessWidget {
  final bool? seenIntro;

  const MyApp({super.key, this.seenIntro});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
        BlocProvider<SignUpBloc>(create: (_) => SignUpBloc()),
        BlocProvider<HomeBloc>(create: (_) => HomeBloc()),



      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.data(),
            home: seenIntro == true ? const SplashScreen() :const IntroScreen(),

      )
    );
  }
}
