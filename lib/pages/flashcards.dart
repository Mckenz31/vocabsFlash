import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:vocabs_flash/models/vocabSet_model.dart';
import '../constants/constants.dart';
import 'package:hive/hive.dart';

class FlashCards extends StatefulWidget {

  final int cardNo;

  FlashCards(this.cardNo);

  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {

  String setName;
  Box<VocabSetModel> setBox;
  String val = Constants().value[0]['word'];
  String meaning = ((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['definition'];
  String example = ((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['example'];
  // String synonym = ((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[1]['synonym'];
  String s1="", s2="", s3="", s4="", s5="", s6="", s7="", synonym="";

  @override
  void initState() {
    super.initState();
    getSynonym();
    print(widget.cardNo);
    setName = Hive.box('vocabSets').getAt(widget.cardNo);
    print(setName);
    Hive.openBox<VocabSetModel>(setName);
    setBox = Hive.box<VocabSetModel>(setName);
  }

  String getSynonym(){
    // print('${((Constants().value[0]['meanings'] as List<dynamic>)[0]['definitions'] as List<dynamic>)[0]['synonyms'].length - 1}');
    print('${((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['synonyms'].length}');
    for(int i=0; i<(((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['synonyms']).length - 1 && i< 7; i++){
      s1 = (((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['synonyms'][1]);
      s2 = (((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['synonyms'][2]);
      s3 = (((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['synonyms'][3]);
      s4 = (((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['synonyms'][4]);
      s5 = (((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['synonyms'][5]);
      s6 = (((Constants().value[0]['meanings'] as List<dynamic>)[1]['definitions'] as List<dynamic>)[0]['synonyms'][6]);
    }
    synonym = s1 + ',' + s2 + ',' + s3 + ',' + s4 + ',' + s5 + ',' + s6;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cardNo);
    return Scaffold(
      appBar: AppBar(
        title: Title(child: Text('Vocab set 1'), color: Colors.red,),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 15,
            child: Container(

              // height: MediaQuery.of(context).size.height/1.5,
              // width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: Center(
                child: FlipCard(
                  fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
                  direction: FlipDirection.HORIZONTAL, // default
                  front: Container(
                    margin: EdgeInsets.all(10),
                    color: Color(0xffF5591F),
                    child: Center(child: Text(setBox.getAt(0).word, style: TextStyle(fontSize: 100,),)),
                  ),
                  back: Container(
                    margin: EdgeInsets.all(10),
                    color: Color(0xffF5591F),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Meaning: ' +setBox.getAt(0).meaning, style: TextStyle(fontSize: 22),),
                        SizedBox(height: 20,),
                        Text('  Example: ' +setBox.getAt(0).example, style: TextStyle(fontSize: 22),),
                        SizedBox(height: 20,),
                        // Text('Synonym: ' +getSynonym(), style: TextStyle(fontSize: 20),),
                        synonym != null ? Text('Synonym: ' +s1 +" ," +s2 +" ," +s3 +" ," +s4 +" ," +s5 +" ," +s6, style: TextStyle(fontSize: 20),) : Text("")
                      ],
                    ),
                  ),
                ),
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
                  ElevatedButton(child: Text('Not at all'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)), onPressed: (){
                    setState(() {
                      print(val);
                    });
                  },),
                  ElevatedButton(child: Text('Almost there'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)), onPressed: (){
                    setState(() {
                      getSynonym();
                    });
                  },),
                  ElevatedButton(child: Text('Yes, got it'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green[500])), onPressed: (){
                    setState(() {
                      //Next stage
                    });
                  },)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

