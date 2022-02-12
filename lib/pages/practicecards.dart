import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vocabs_flash/models/vocabSet_model.dart';
import 'package:audioplayers/audioplayers.dart';

class PracticeCards extends StatefulWidget {
  String boxName = Hive.box('vocabSets').getAt(0);
  @override
  _PracticeCardsState createState() => _PracticeCardsState();
}

class _PracticeCardsState extends State<PracticeCards> {
  @override
  Widget build(BuildContext context) {
    // String boxName = Hive.box('vocabSets').getAt(0);
    Box mainBox = Hive.box('vocabSets');
    Box<VocabSetModel> listBox;
    AudioPlayer audioPlayer = AudioPlayer();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lists'),
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
      body: VocabLists(boxName: widget.boxName),
    );
  }
}

class VocabLists extends StatelessWidget {
  VocabLists({
    @required this.boxName,
  });

  final String boxName;
  AudioPlayer audioPlayer = AudioPlayer();

  play(String url) async {
    await audioPlayer.play("https://" + url);
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    print(boxName);
    return ValueListenableBuilder(
      valueListenable: Hive.box<VocabSetModel>(boxName).listenable(),
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
                        right: BorderSide(width: 2.2, color: Colors.white30),
                    ),
                ),
                child: Text(index.toString()),
              ),
              title: Text(
                '${box.getAt(index).word}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              trailing: Icon(Icons.volume_up, color: Colors.white, size: 30.0),
              onTap: () {
                play(box.getAt(index).audioURL);
              },
            );
          },
        );
      },
    );
  }
}
