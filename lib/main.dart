import 'package:flutter/material.dart';
import 'pages/flashcards.dart';
import 'pages/landingPage.dart';
import 'pages/flashcards.dart';

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
        '/landingPage': (context) => landingPage(),
        '/flashCards': (context) => FlashCards(),
      },
      home: landingPage(),
    );
  }
}
