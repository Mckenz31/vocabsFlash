import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: SizedBox(
              height: 10,
            ),
          ),
          Flexible(
            flex: 10,
            child: IntroductionScreen(
              pages: [
                PageViewModel(
                  title: "Quick learning",
                  body: "We have a dictionary provided for you to search for words and add them as flashCards to your customized sets.",
                  image: Center(child: Image.asset("assets/img-1.jpg", height: MediaQuery.of(context).size.height/2, width: MediaQuery.of(context).size.width,)),
                ),
                PageViewModel(
                  title: "We believe in you",
                  body: "  You have already made a step towards achieving your goal, never stop believing in yourself. You can achieve anything ",
                  image: Center(child: Image.asset("assets/img-3.jpg", height: MediaQuery.of(context).size.height/2, width: MediaQuery.of(context).size.width,)),
                ),
                PageViewModel(
                  title: "Remember to have fun",
                  body: " \"What we learn with pleasure we never forget \" by Alfred Mercier ",
                  image: Center(child: Image.asset("assets/img-2.jpg", height: MediaQuery.of(context).size.height/2, width: MediaQuery.of(context).size.width,)),
                ),
              ],
              done: Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
              onDone: () {
                Navigator.pushNamed(context, '/landingPage');
              },
              showNextButton: false,
            ),
          ),
        ],
      ),
    );
  }
}
