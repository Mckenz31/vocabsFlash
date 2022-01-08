import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'pages/flashcards.dart';
import 'pages/landingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        '/': (context) => LandingPage(),
        '/flashCards': (context) => FlashCards(),
      },
      initialRoute: kDebugMode
          ? String.fromEnvironment('START_PATH', defaultValue: '/')
          : '/',
    );
  }
}
