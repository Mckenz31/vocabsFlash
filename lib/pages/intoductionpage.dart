import 'package:vocabs_flash/main.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  List<PageViewModel> listViewModel=[
      PageViewModel(
        image: Image.asset('assets/img-1.png'),
        title: 'Quick learning',
        body: 'Flashcards make learning easy'
      ),

      PageViewModel(
        image: Image.asset('assets/img-2.png'),
        title: 'Future of learning',
        body: 'Learning is easy for everyone',
      ),

      PageViewModel(
        image: Image.asset('assets/img-3.png'),
        title: 'Easily Accessible',
        body: 'Make your life easier'
      ),

    ];




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IntroductionScreen(
          done:Text('Done',style:TextStyle(
            color: Colors.black,
          ),),
          showNextButton: false,
          onDone: (){
            Navigator.pushNamed(context, '/landingPage');
          },
          pages: listViewModel,
          globalBackgroundColor: Colors.white,
        ) ,
      ),
    );
  }
}