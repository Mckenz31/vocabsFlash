import 'package:flutter/material.dart';
import 'package:vocabs_flash/constants/constants.dart';
import 'flashcards.dart';

class VocabSets extends StatefulWidget {
  @override
  _VocabSetsState createState() => _VocabSetsState();
}

class _VocabSetsState extends State<VocabSets> {

  int _tempVal = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Title(
          color: Colors.purple,
          child: Text("Vocabulary sets to learn")
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemCount: _tempVal,
          itemBuilder: (context, index) {
            return Container(
              height: MediaQuery.of(context).size.height/4,
              // color: Colors.white24,
              margin: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  // Navigator.pushNamed(context, '/flashCards', arguments: index);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FlashCards(index)),);
                },
                child: Card(
                  shadowColor: Colors.white12,
                  elevation: 10,
                  color: Colors.white24,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${Constants().cardz[index].title}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Learnt: ${Constants().cardz[index].learnt}"),
                          Text("In progress: ${Constants().cardz[index].inProcess}"),
                          Text("Unfamiliar: ${Constants().cardz[index].incomplete}"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: LinearProgressIndicator(
                          semanticsLabel: "Linear progress indicator",
                          minHeight: 20,
                          value: Constants().cardz[index].progressVal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
