import 'package:flutter/material.dart';
import 'dart:async';

class PracticeCards extends StatefulWidget {
  @override
  _PracticeCardsState createState() => _PracticeCardsState();
}

class _PracticeCardsState extends State<PracticeCards> {

  Timer _timer;
  int _seconds = 60;
  int _points = 0;

  void beginTimer(){
    const time = const Duration(seconds: 1);
    _timer = new Timer.periodic(time, (Timer timer){
      if(_seconds == 0){
        setState(() {
          _timer.cancel();
        });
      }
      else{
        setState(() {
          _seconds--;
          print(_seconds);
        });
      }
    });
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    beginTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Title(color: Colors.deepOrangeAccent, child: Text('Practice')),),
      body: Container(
        color: Colors.deepOrange,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Container(
                //   // margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     color: Colors.black,
                //     borderRadius: BorderRadius.circular(30)
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(25.0),
                //     child: Text('$_seconds'),
                //   ),
                // ),
                Text("Timer: " +_seconds.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.black)),
                Text("Points: " +_points.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.black)),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.height,
              // color: Colors.deepOrange,
              child: Card(
                color: Colors.deepOrange,
                child: Center(child: Text("hello", style: TextStyle(fontSize: 59, fontWeight: FontWeight.w900),)),
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
