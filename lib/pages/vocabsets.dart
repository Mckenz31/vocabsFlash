import 'package:flutter/material.dart';

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
                  Navigator.pushNamed(context, '/flashCards');
                },
                child: Card(
                  shadowColor: Colors.white12,
                  elevation: 10,
                  color: Colors.white24,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "GRE words",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Learned: 10"),
                          Text("To revise: 10"),
                          Text("Unknown: 10"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: LinearProgressIndicator(
                          semanticsLabel: "Linear progress indicator",
                          minHeight: 20,
                          value: 0.33,
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
