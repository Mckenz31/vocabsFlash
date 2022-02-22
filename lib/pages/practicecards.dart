import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabs_flash/models/vocabSet_model.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PracticeCards extends StatefulWidget {
  String boxName = Hive.box('vocabSets').getAt(0);
  @override
  _PracticeCardsState createState() => _PracticeCardsState();
}

class _PracticeCardsState extends State<PracticeCards> {

    Box mainBox = Hive.box('vocabSets');
    Box<VocabSetModel> listBox;
    FlutterTts _flutterTTs = FlutterTts();
    bool isPlaying = false;

    void initializeTts(){
      _flutterTTs.setStartHandler(() {
        setState(() {
          isPlaying = true;
        });
      });
      _flutterTTs.setCompletionHandler(() {
        setState(() {
          isPlaying = false;
        });
      });
      _flutterTTs.setErrorHandler((message) {
        setState(() {
          isPlaying = false;
        });
      });
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeTts();
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
    Widget build(BuildContext context) {
    bool mode = Hive.box('settings').get('darkMode', defaultValue: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lists'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: mainBox.length > 0
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Text('Vocabulary Lists'),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/img-4.jpg"),
                        ),
                    ),
                  ),
                  for (int i = 0; i < mainBox.length; i++)
                    ListTile(
                      title: Text('${mainBox.getAt(i)}'),
                      onTap: () {
                        setState(() {
                          widget.boxName = Hive.box('vocabSets').getAt(i);
                        });
                      },
                    ),
                ],
              ),
            )
          : Drawer(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<VocabSetModel>(widget.boxName).listenable(),
        builder: (context, Box box, widget) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(width: 2.2, color: mode ? Colors.white30 : Colors.black),
                    ),
                  ),
                  child: Text(index.toString()),
                ),
                title: Text(
                  '${box.getAt(index).word}',
                  style:
                  TextStyle(color: mode ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Text('${box.getAt(index).meaning}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),),
                        )),
                  ],
                ),
                trailing: Icon(Icons.volume_up, color: mode ? Colors.white : Colors.black, size: 30.0),
                onTap: () {
                  speech(box.getAt(index).word);
                },
              );
            },
          );
        },
      ),
    );
  }
}

