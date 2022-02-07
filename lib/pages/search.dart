import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vocabs_flash/models/vocabSet_model.dart';
import 'package:vocabs_flash/result.dart';
import 'package:hive/hive.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  Meaning result;
  String dropDownVal = 'Select a set';
  List<String> dropDownItems = ['Select a set'];
  final sets = Hive.box('vocabSets');

  Future getMeaning(String word) async {
    var response = await http
        .get(Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en/$word'));
    var jsonData = jsonDecode(response.body);
    setState(() {
      result = Meaning(
          word: jsonData[0]['word'],
          meanings: jsonData[0]['meanings'][0]['definitions'][0]['definition'],
          audioUrl: jsonData[0]['phonetics'][0]['audio'],
          antonyms: jsonData[0]['meanings'][0]['definitions'][0].containsKey('antonyms') &&
                  jsonData[0]['meanings'][0]['definitions'][0]['antonyms'].length >
                      0
              ? jsonData[0]['meanings'][0]['definitions'][0]['antonyms'].length >
                      4
                  ? jsonData[0]['meanings'][0]['definitions'][0]['antonyms']
                      .sublist(0, 4)
                  : jsonData[0]['meanings'][0]['definitions'][0]['antonyms']
              : ['No Antonyms Found'],
          synonyms: jsonData[0]['meanings'][0]['definitions'][0].containsKey('synonyms') &&
                  jsonData[0]['meanings'][0]['definitions'][0]['synonyms'].length >
                      0
              ? jsonData[0]['meanings'][0]['definitions'][0]['synonyms'].length > 4 ? jsonData[0]['meanings'][0]['definitions'][0]['synonyms'].sublist(0, 4) : jsonData[0]['meanings'][0]['definitions'][0]['synonyms']
                  
              : ['No Synonyms Found'],
          example: jsonData[0]['meanings'][0]['definitions'][0].containsKey('example')
              ? jsonData[0]['meanings'][0]['definitions'][0]['example']
              : "No Example Found",);
    });
    print(result.antonyms);
  }


  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for(int i=0; i<sets.length; i++){
      dropDownItems.add(sets.getAt(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('Search')),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        hintText: "Enter the word here",
                        labelText: "Search",
                        labelStyle:
                            TextStyle(fontSize: 24, color: Colors.black),
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => getMeaning(_searchController.text),
                        )),
                    maxLength: 15,
                    onSubmitted: (value){
                      getMeaning(_searchController.text);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Word : ' + _searchController.text,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(
                    height: 15,
                  ),
                  result != null ? Result(result) : Text(''),
                ],
              ),
            ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                dropdownColor: Colors.red,
                value: dropDownVal,
                onChanged: (value){
                  setState(() {
                    dropDownVal = value;
                  });
                },
                items: dropDownItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: (){
                  if(dropDownVal != 'Select a set' && _searchController.text != null){
                    final setName = Hive.box<VocabSetModel>(dropDownVal);
                    final values = VocabSetModel(word: result.word, meaning: result.meanings, learnt: false, inProcess: false, inComplete: true, synonym: result.synonyms, antonym: result.antonyms, example: result.example, audioURL: result.audioUrl);
                    setName.add(values);
                    final snackBar = SnackBar(content: Text('Word added'),
                      backgroundColor: Colors.green,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  else{
                    final snackBar = SnackBar(content: Text('Select a set from the dropdown list. If no set exist, create a new set in the flashcards page. Then come back and select the set'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Meaning {
  final String word, audioUrl, meanings, example, origin;
  List<dynamic> antonyms, synonyms;
  Meaning({this.word,
      this.meanings,
      this.audioUrl,
      this.example,
      this.synonyms,
      this.antonyms,
      this.origin});
}
