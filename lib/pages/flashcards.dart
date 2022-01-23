import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:vocabs_flash/models/vocabSet_model.dart';
import 'package:hive/hive.dart';
import 'package:audioplayers/audioplayers.dart';

class FlashCards extends StatefulWidget {
  final int cardNo;

  FlashCards(this.cardNo);

  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  int val;
  String setName;
  Box<VocabSetModel> setBox;
  AudioPlayer audioPlayer = AudioPlayer();
  // String synonym = ((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[1]['synonym'];
  String s1 = "",
      s2 = "",
      s3 = "",
      s4 = "",
      s5 = "",
      s6 = "",
      s7 = "",
      synonym = "";

  @override
  void initState() {
    super.initState();
    print(widget.cardNo);
    setName = Hive.box('vocabSets').getAt(widget.cardNo);
    print(setName);
    Hive.openBox<VocabSetModel>(setName);
    setBox = Hive.box<VocabSetModel>(setName);
    print(setBox.getAt(0).synonym[0]);
  }

  play(String url) async {
    await audioPlayer.play("https://" +url);
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cardNo);
    return Scaffold(
      appBar: AppBar(
        title: Title(
          child: Text('Vocab set 1'),
          color: Colors.red,
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 15,
            child: Container(
              child: Center(
                child: buildFlipCard(),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Text('Familiar with the term?'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 2,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: Text('Yes, got it'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green[500])),
                    onPressed: () {
                      setState(() {
                        setBox.getAt(val).learnt = true;
                        setBox.getAt(val).inProcess = false;
                        setBox.getAt(val).inComplete = false;
                        buildFlipCard();
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text('Almost there'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.orange)),
                    onPressed: () {
                      setState(() {
                        setBox.getAt(val).inProcess = true;
                        setBox.getAt(val).learnt = false;
                        setBox.getAt(val).inComplete = false;
                        buildFlipCard();
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text('Not at all'),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () {
                      setState(() {
                        setBox.getAt(val).inProcess = false;
                        setBox.getAt(val).learnt = false;
                        setBox.getAt(val).inComplete = true;
                        buildFlipCard();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlipCard buildFlipCard() {
    List<int> values = [];
    for(int i=0; i<setBox.length; i++){
      if(setBox.getAt(i).learnt == true){
        //
      }
      else{
        values.add(i);
      }
    }
    if(values.length == 0){
      final snackBar = SnackBar(
        content: Text('The set is completed'),
        backgroundColor: Colors.green,
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
    }
    else{
      Random random = new Random();
      // val = random.nextInt(values.length - 1);
      val = values[random.nextInt(values.length)];
      return FlipCard(
        fill: Fill
            .fillBack, // Fill the back side of the card to make in the same size as the front.
        direction: FlipDirection.HORIZONTAL, // default
        front: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          color: Color(0xffF5591F),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                setBox.getAt(val).word,
                style: TextStyle(
                  fontSize: 100,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // audioPlayer.play(setBox.getAt(0).audioURL);
                  play(setBox.getAt(val).audioURL);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.speaker_phone,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
        back: Container(
          margin: EdgeInsets.all(10),
          color: Color(0xffF5591F),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Meaning: ' + setBox.getAt(val).meaning,
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '  Example: ' + setBox.getAt(val).example,
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 20,
              ),
              // Text('Synonym: ' +getSynonym(), style: TextStyle(fontSize: 20),),
              setBox.getAt(val).synonym[0] != "No Synonyms Found"
                  ? Text(
                'Synonym: ' +
                    setBox.getAt(val).synonym[0] +
                    " ," +
                    setBox.getAt(val).synonym[1] +
                    " ," +
                    setBox.getAt(val).synonym[2] +
                    " ," +
                    setBox.getAt(val).synonym[3],
                style: TextStyle(fontSize: 20),
              )
                  : Text("")
            ],
          ),
        ),
      );
    }
  }
}
