import 'dart:async';
import 'dart:math';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flacabulary/models/vocabSet_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:flacabulary/models/flashCardChange.dart';

class FlashCards extends StatefulWidget {
  final int cardNo;

  FlashCards(this.cardNo);

  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  List<int> values = [];
  List<int> valCheck = [];
  bool completed = false;
  bool wordsAvailable = false;
  String currentFlashCard = "";
  int val;
  String setName;
  Box<VocabSetModel> setBox;
  FlutterTts _flutterTTs = FlutterTts();
  bool isPlaying = false;
  FlipCardController _controller;
  bool toFlip = false;
  bool cardChange = false;

  void initializeTts() {
    _flutterTTs.setStartHandler(() {
      isPlaying = true;
    });
    _flutterTTs.setCompletionHandler(() {
      isPlaying = false;
    });
    _flutterTTs.setErrorHandler((message) {
      isPlaying = false;
    });
  }

  void speech(String word) async {
    await _flutterTTs.speak(word);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _flutterTTs.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
    initializeTts();
    print(widget.cardNo);
    setName = Hive.box('vocabSets').getAt(widget.cardNo);
    print(setName);
    Hive.openBox<VocabSetModel>(setName);
    setBox = Hive.box<VocabSetModel>(setName);
    if (setBox.length > 0) {
      wordsAvailable = true;
    }
    for (int i = 0; i < setBox.length; i++) {
      if (setBox.getAt(i).learnt == true) {
        //
      } else {
        valCheck.add(i);
      }
    }
    if (valCheck.length == 0) completed = true;
  }

  Color updateCardColor(){
    Provider.of<flashCardChange>(context, listen: false).changeColor();
  }

  void doStuff() {
    if (toFlip == true) {
      toFlip = false;
      print("Flip" + toFlip.toString());
      _controller.toggleCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cardNo);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Title(
          child: Text(setName),
          color: Colors.red,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: PopupMenuButton(
              child: Icon(Icons.more_vert),
              // color: Colors.green,
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Start learning again"),
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < setBox.length; i++) {
                        setBox.putAt(
                            i,
                            VocabSetModel(
                                learnt: false,
                                inProcess: false,
                                inComplete: true,
                                meaning: setBox.getAt(i).meaning,
                                example: setBox.getAt(i).example,
                                word: setBox.getAt(i).word,
                                audioURL: setBox.getAt(i).audioURL,
                                synonym: setBox.getAt(i).synonym,
                                antonym: setBox.getAt(i).antonym));
                        completed = false;
                        buildColumn();
                      }
                    });
                  },
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Delete word"),
                  onTap: () {
                    setState(() {
                      setBox.deleteAt(val);
                    });
                  },
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Delete entire set"),
                  onTap: () {
                    setState(() {
                      setBox.clear();
                      Hive.box('vocabSets').deleteAt(widget.cardNo);
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: buildColumn(),
    );
  }

  Column buildColumn() {
    return Column(
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
        completed
            ? Container()
            : Flexible(
                flex: 1,
                child: Container(
                  child: Text('Familiar with the term?'),
                ),
              ),
        SizedBox(
          height: 10,
        ),
        completed
            ? Container()
            : Flexible(
                flex: 2,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: Text('Not at all'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                        onPressed: () {
                          doStuff();
                          Timer(Duration(milliseconds: 500), () {
                            setState(() {
                              setBox.putAt(
                                  val,
                                  VocabSetModel(
                                      learnt: false,
                                      inProcess: true,
                                      inComplete: false,
                                      meaning: setBox.getAt(val).meaning,
                                      example: setBox.getAt(val).example,
                                      word: setBox.getAt(val).word,
                                      audioURL: setBox.getAt(val).audioURL,
                                      synonym: setBox.getAt(val).synonym,
                                      antonym: setBox.getAt(val).antonym));
                              // buildColumn();
                            });
                          });
                        },
                      ),
                      ElevatedButton(
                        child: Text('Almost there'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.orange)),
                        onPressed: () {
                          doStuff();
                          Timer(Duration(milliseconds: 500), () {
                            setState(() {
                              setBox.putAt(
                                  val,
                                  VocabSetModel(
                                      learnt: false,
                                      inProcess: true,
                                      inComplete: false,
                                      meaning: setBox.getAt(val).meaning,
                                      example: setBox.getAt(val).example,
                                      word: setBox.getAt(val).word,
                                      audioURL: setBox.getAt(val).audioURL,
                                      synonym: setBox.getAt(val).synonym,
                                      antonym: setBox.getAt(val).antonym));
                              // buildColumn();
                            });
                          });
                        },
                      ),
                      ElevatedButton(
                        child: Text('Yes, got it'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green[500])),

                        onPressed: () {
                          doStuff();
                          Timer(Duration(milliseconds: 500), () {
                            setState(() {
                              setBox.putAt(
                                  val,
                                  VocabSetModel(
                                      learnt: true,
                                      inProcess: false,
                                      inComplete: false,
                                      meaning: setBox.getAt(val).meaning,
                                      example: setBox.getAt(val).example,
                                      word: setBox.getAt(val).word,
                                      audioURL: setBox.getAt(val).audioURL,
                                      synonym: setBox.getAt(val).synonym,
                                      antonym: setBox.getAt(val).antonym));
                              buildColumn();
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  buildFlipCard() {
    values.clear();
    for (int i = 0; i < setBox.length; i++) {
      //To not repeat the words that the user got right
      if (setBox.getAt(i).learnt == true) {
        //
      }
      //Add the words which are not learnt
      else {
        values.add(i);
      }
    }
    //If no cards left
    if (values.length == 0) {
      completed = true;
      print("Ran1");
      return wordsAvailable
          ? Container(
              child: Text("Completed"),
            )
          : Container(
              child: Center(
                  child: Text("Go to -> Browse words page -> add words")),
            );
    }

    //If only a single card is left
    else if (values.length == 1) {
      Random random = new Random();
      val = values[random.nextInt(values.length)];
      currentFlashCard = setBox.getAt(val).word;
      print("Ran");
      return buildFlipCardP2();
    }

    //If many cards are there
    else {
      for (int i = 0; i < values.length; i++) {
        if (currentFlashCard == setBox.getAt(i).word) {
          print("Now0: " +
              setBox.getAt(i).word +
              ", Before0: " +
              currentFlashCard);
          print(values[i]);
          values.removeAt(i);
        }
      }
      Random random = new Random();
      // val = random.nextInt(values.length - 1);
      print("Valuesssssss" + values.toString());
      val = values[random.nextInt(values.length)];
      print("Now: " + setBox.getAt(val).word + ", Before: " + currentFlashCard);

      //Checking if the card is a repeat and making sure we do not use a card which is repeated
      if (currentFlashCard == setBox.getAt(val).word) {
        int value = val;
        while (val == value) {
          val = values[random.nextInt(values.length)];
        }
      }
      currentFlashCard = setBox.getAt(val).word;
      return buildFlipCardP2();
    }
  }

  FlipCard buildFlipCardP2() {
    updateCardColor();
    return FlipCard(
      controller: _controller,
      fill: Fill.fillBack,
      onFlipDone: (status) {
        toFlip = status;
        print("Status" + status.toString());
      },
      direction: FlipDirection.HORIZONTAL, // default
      front: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        color: Provider.of<flashCardChange>(context).getColor,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  setBox.getAt(val).word,
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  speech(setBox.getAt(val).word);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.volume_up,
                    size: 50,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Flip"),
                Icon(Icons.next_plan),
              ],
            ),
          ],
        ),
      ),
      back: Container(
        margin: EdgeInsets.all(10),
        color: Provider.of<flashCardChange>(context).getColor,
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
            setBox.getAt(val).example != "No Example Found"
                ? Text(
                    '  Example: ' + setBox.getAt(val).example,
                    style: TextStyle(fontSize: 22),
                  )
                : Text(""),
            SizedBox(
              height: 20,
            ),
            // Text('Synonym: ' +getSynonym(), style: TextStyle(fontSize: 20),),
            (setBox.getAt(val).synonym[0] != "No Synonyms Found" &&
                    setBox.getAt(val).synonym[0] != "No Antonyms Found")
                ? buildText()
                : Text(""),
          ],
        ),
      ),
    );
  }

  Text buildText() {
    String synoymn = "Synonym: ";
    for(int i=0; i<setBox.getAt(val).synonym.length; i++){
      if(i == setBox.getAt(val).synonym.length-1){
        synoymn = synoymn + setBox.getAt(val).synonym[i] + ".";
      }
      else{
        synoymn = synoymn + setBox.getAt(val).synonym[i] + ", ";
      }
    }
    return Text(
      synoymn,
      style: TextStyle(fontSize: 20),
    );
  }
}
