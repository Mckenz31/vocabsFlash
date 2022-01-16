import 'package:flutter/material.dart';
import 'package:vocabs_flash/pages/vocabsets.dart';
import 'pages/flashcards.dart';
import 'pages/intoductionpage.dart';
import 'package:flutter/foundation.dart';
import 'package:vocabs_flash/pages/practicecards.dart';
import 'pages/landingpage.dart';
import 'package:vocabs_flash/search.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
// reject this comment in merge conflict

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
/*

reject this blank space
in merge conflict

*/
  runApp(MyApp(await Hive.openBox('settings')));
}

class MyApp extends StatefulWidget {
  final Box settings;
  MyApp(this.settings);
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
        '/landingPage': (context) => LandingPage(),
        '/introductionPage': (context) => IntroductionPage(),
        '/vocabSets': (context) => VocabSets(),
        // '/flashCards': (context) => FlashCards(),
        '/search': (context) => Search(),
        '/practiceCards': (context) => PracticeCards()
      },
      initialRoute: widget.settings.get('isFirstTime') != false
          ? '/introductionPage'
          : '/landingPage',
    );
  }
}
