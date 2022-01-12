import 'package:flutter/material.dart';
import 'package:vocabs_flash/pages/vocabsets.dart';
import 'pages/flashcards.dart';
import 'pages/intoductionpage.dart';
import 'package:flutter/foundation.dart';
import 'package:vocabs_flash/pages/practicecards.dart';
import 'pages/landingpage.dart';
import 'package:vocabs_flash/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      routes: {
        '/': (context) => IntroductionPage(),
        '/landingPage' : (context) => LandingPage(),
        '/vocabSets' : (context) => VocabSets(),
        // '/flashCards': (context) => FlashCards(),
        '/search': (context) => Search(),
        '/practiceCards': (context) => PracticeCards()
      },
      initialRoute: kDebugMode
          ? const String.fromEnvironment('START_PATH', defaultValue: '/')
          : '/',
    );
  }
}
