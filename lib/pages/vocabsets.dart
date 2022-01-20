import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vocabs_flash/constants/constants.dart';
import 'flashcards.dart';
import 'package:vocabs_flash/models/vocabSet_model.dart';
import 'package:provider/provider.dart';
import 'package:vocabs_flash/providers/hivenewset_provider.dart';

class VocabSets extends StatefulWidget {
  @override
  _VocabSetsState createState() => _VocabSetsState();
}

class _VocabSetsState extends State<VocabSets> {
  final formKey = GlobalKey<FormState>();
  String setName;
  Box<VocabSetModel> indivBox;
  final setData = Hive.box('vocabSets');
  int learnt, inProgress, unFamiliar;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   for(int i=0; i<setData.length; i++){
  //     Hive.box(setData.name);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Title(
            color: Colors.purple, child: Text("Vocabulary sets to learn")),
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          height: 200,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Create a new vocab set',
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              Form(
                                key: formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 30.0),
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0.0),
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
                                    print(setData.length);
                                    setData.put(setData.length, setName);
                                    Provider.of<HiveNewSet>(context, listen: false).newBox(setName);
                                    final snackBar = SnackBar(
                                      content: Text('Set: $setName'),
                                      backgroundColor: Colors.lightBlueAccent,
                                    );
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
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
                                          Colors.red),
                                ),
                              ),
                            ],
                          ),
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
                  indivBox = Hive.box<VocabSetModel>(setsBox.getAt(index));
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
                        );
                      },
                      child: Card(
                        shadowColor: Colors.white12,
                        elevation: 10,
                        color: Colors.white24,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${setsBox.getAt(index)}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            indivBox.length > 0
                                ?
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      "Learnt: ${Constants().cardz[index].learnt}"),
                                  Text(
                                      "In progress: ${Constants().cardz[index].inProcess}"),
                                  Text(
                                      "Unfamiliar: ${Constants().cardz[index].incomplete}"),
                                ],
                              )
                                :
                              Text("No Flash Cards Created Yet"),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, right: 18.0),
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
                });
          },
        ),
      ),
    );
  }
}
