import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'flashcards.dart';
import 'package:vocabs_flash/models/vocabSet_model.dart';
import 'package:provider/provider.dart';
import 'package:vocabs_flash/providers/hivenewset_provider.dart';
import 'dart:async';

class VocabSets extends StatefulWidget {
  @override
  _VocabSetsState createState() => _VocabSetsState();
}

class _VocabSetsState extends State<VocabSets> {
  final formKey = GlobalKey<FormState>();
  String setName;
  Box<VocabSetModel> indivBox;
  final setData = Hive.box('vocabSets');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool mode = Hive.box('settings').get('darkMode');
    return Scaffold(
      backgroundColor: mode ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mode ? Colors.white12 : Colors.deepOrange,
        title: Title(
            color: Colors.black,
            child: Text("Vocabulary sets to learn")),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: mode ? MaterialStateProperty.all<Color>(Colors.deepOrange) : MaterialStateProperty.all<Color>(Colors.blue[900]),
              ),
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Create a new vocab set',
                                style: TextStyle(
                                  // color: Colors.black,
                                )),
                            SizedBox(height: 10,),
                            Form(
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 30.0),
                                child: TextFormField(
                                  style: TextStyle(
                                    // color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: mode ? Colors.white : Colors.black,
                                          width: 5.0),
                                    ),
                                    labelText: 'Vocab set name',
                                  ),
                                  validator: (value) {
                                    if (value.length < 2) {
                                      return 'Enter at least 2 characters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      setName = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final isValid =
                                    formKey.currentState.validate();
                                if (isValid) {
                                  formKey.currentState.save();
                                  setData.add(setName);
                                  Provider.of<HiveNewSet>(context,
                                          listen: false)
                                      .newBox(setName);
                                  final snackBar = SnackBar(
                                    content: Text('Set: $setName'),
                                    backgroundColor: Colors.lightBlueAccent,
                                  );
                                  Future.delayed(const Duration(milliseconds: 500), () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                }
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('vocabSets').listenable(),
          builder: (context, setsBox, widget) {
            return ListView.builder(
                itemCount: setsBox.length,
                itemBuilder: (context, index) {
                  int inProgress = 0, learnt = 0, unFamiliar = 0;
                  int total = 0;
                  double value;
                  indivBox = Hive.box<VocabSetModel>(setsBox.getAt(index));
                  for (int i = 0; i < indivBox.length; i++) {
                    if (indivBox.getAt(i).inProcess)
                      inProgress++;
                    else if (indivBox.getAt(i).learnt)
                      learnt++;
                    else
                      unFamiliar++;
                  }
                  total = learnt + inProgress + unFamiliar;
                  value = total == 0 ? 0 : learnt / total;
                  return Container(
                    height: MediaQuery.of(context).size.height / 4,
                    // color: Colors.white24,
                    margin: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/flashCards', arguments: index);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlashCards(index)),
                        ).then((_) {
                          // This block runs when you have returned back to the 1st Page from 2nd.
                          setState(() {
                            // Call setState to refresh the page.
                          });
                        });
                      },
                      child: Card(
                        shadowColor: mode ? Colors.white12 : Colors.deepOrange,
                        elevation: 10,
                        color: mode ? Colors.white24 : Colors.deepOrange,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${setsBox.getAt(index)}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            indivBox.length > 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("Learnt: $learnt", style: TextStyle(color: Colors.white),),
                                      Text("In progress: $inProgress", style: TextStyle(color: Colors.white),),
                                      Text("Unknown: $unFamiliar", style: TextStyle(color: Colors.white),),
                                    ],
                                  )
                                : Text("No Flash Cards Created Yet", style: TextStyle(color: Colors.white),),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, right: 18.0),
                              child: LinearProgressIndicator(
                                semanticsLabel: "Linear progress indicator",
                                minHeight: 20,
                                value: value,
                                backgroundColor: Colors.white,
                                color: mode ? Colors.deepOrange : Colors.blue[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
