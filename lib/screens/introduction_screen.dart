
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quran_aziz/screens/splash_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/images.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    _checkIfFirstTime();
  }

  // Check if it's the first time the user opens the app
  Future<void> _checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? seen = prefs.getBool('seenIntro');

    if (seen == true) {
      // If the user has already seen the intro screen, navigate to the home screen
      _navigateToHome();
    }
  }

  // Save that the intro screen has been shown and navigate to home
  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenIntro', true);

    _navigateToHome();
  }

  // Function to navigate to the home screen
  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SplashScreen()), // Replace HomeScreen with your actual home screen widget
    );
  }

  @override
  Widget build(BuildContext context) {


    return IntroductionScreen(
      pages: [
        _pageViewModel(title: "Welcome To Quran-e-Aziz App",body: paragraph,imagePath: Images.hazratImage),
        _pageViewModel(title: "Features of Application",body: "We cover essential features such as Qibla direction, Prayer Timings, upcoming and current prayer times, the Islamic calendar, Duas (Prayers), Seerat-un-Nabi (The Life of the Prophet Muhammad), and Ahadith (Sayings of the Prophet Muhammad).",imagePath: Images.quranAzizImage)

        // Add more pages as needed
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can skip the intro
      showSkipButton: true,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.blue,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget _buildImage(String assetName) {
    return Center(child: ClipOval(

        child: Image.asset(assetName, width: 280.0,height: 280.0, fit: BoxFit.fill,)));
  }
  _pageViewModel({String? title, String? body, String? imagePath}){
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 16.0),
      bodyPadding: EdgeInsets.all(16.0),
      imagePadding: EdgeInsets.all(24.0),
      pageColor: Colors.white,
    );
    return PageViewModel(
      title: title,
      body: body,
      image: _buildImage(imagePath!),
      decoration: pageDecoration,
    );

  }
  String paragraph = "Quran-e-Aziz is the name of a Tafseer (exegesis) of the Quran, written by Molana Ahmad Ali Lahori, a revered Islamic scholar. He is known by the title Imam al-Awliya Shaykh al-Tafsir Molana Ahmad Ali Lahori (رحمه الله). Among the Awliya' Allah (Friends of Allah), his name commands immense respect, causing even the greatest scholars and venerable figures to bow their heads in reverence and shed tears of love and devotion.On Saturday, April 13, 2019, it was said about him: Imam al-Awliya Shaykh al-Tafsir Molana Ahmad Ali Lahori** (رحمه الله) is among those Awliya' Allah whose mere mention brings tears to the eyes of the pious and whose memory inclines their hearts toward reverence and love. He was one of those blessed servants of Allah, endowed with a heart that wept for the sake of Allah, eyes that brimmed with tears, and a radiant face. His hands, raised in supplication in the solitude of the night, would draw down Allah's mercy and forgiveness. Allah had filled his heart with such light and remembrance that he could discern what was pure or forbidden by merely sensing it. This translation captures both the essence and reverence associated with Molana Ahmad Ali Lahori (رحمه الله), emphasizing his esteemed status among scholars and his deep spiritual connection with Allah.";
}
