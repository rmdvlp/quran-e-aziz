import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quran_aziz/screens/home_screen.dart';
import 'package:quran_aziz/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/apptheme.dart';
import '../utils/images.dart';
import '../utils/size_config.dart';
import '../widgets/navBar.dart';
import 'authScreen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    sizeConfig = SizeConfig.init(context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 2),
        () => _registration()
            );
    //checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DelayedDisplay(
            fadingDuration: const Duration(milliseconds: 1800),
            slidingCurve: Curves.slowMiddle,
            // slidingBeginOffset:  Offset(1.2, 1.2),
            child: Column(
              children: [
                Text(
                  "Quran e Aziz",
                  style: AppTheme.textTheme.displayLarge,
                ),
                Text(
                  "Mawlana Ahmad Ali Lahori (RA)",
                  style: AppTheme.textTheme.labelLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          DelayedDisplay(
            fadingDuration: const Duration(milliseconds: 1800),
            slidingCurve: Curves.slowMiddle,
            // slidingBeginOffset:  Offset(0, -1.2),
            child: Center(
                child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  alignment: const Alignment(-.39, 0),
                  image: AssetImage(Images.quranAzizImage),
                  fit: BoxFit.fill,
                ),
              ),
            )

                ),
          ),




        ],
      ),
    );
  }

  void autoLogin() async {
    double screenWidth = MediaQuery.of(context).size.width;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idToken = prefs.getString("googleIdToken");
    String? accessToken = prefs.getString("googleAccessToken");

    if (idToken != null && accessToken != null) {
      // Attempt to sign in with the stored Google token
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signInSilently();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
        if (result.user != null) {
          // Successfully signed in, navigate to home screen
          screenWidth > 800 ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage())):
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyNavBar()));
        } else {
          // Handle the error (e.g., navigate to login screen)
        }
      } else {
        // Google sign in failed silently, navigate to login screen
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } else {
      // No Google tokens saved, navigate to login screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  _registration() async {
    double screenWidth = MediaQuery.of(context).size.width;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? password = prefs.getString("password");

    print("email and passwrod here $email $password");
    if (password != null && email != null) {

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);



        screenWidth > 800 ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage())):
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyNavBar()));
      } on FirebaseAuthException catch (e) {
        print("my exceptoin hwhen login >>>>>>>${e.code}");
        _exceptionScreen();
        if (e.code == "invalid-credential") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.errorTextColor,
              content: Center(child: Text(e.code))));
          _exceptionScreen();
        } else if (e.code == "network-request-failed") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.errorTextColor,
              content: Center(child: Text(e.code))));
          _exceptionScreen();
        }else if (e.code == "wrong-password") {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              backgroundColor: AppColors.errorTextColor,
              content:Center(child: Text(e.code))));
          _exceptionScreen();
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something went wrong \n $e")));
        _exceptionScreen();
      }
    } else{
      // _exceptionScreen();
      autoLogin();

    }
  }

  _exceptionScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
