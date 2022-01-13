import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vocabs_flash/models/flashcardList.dart';
import 'package:vocabs_flash/models/flashcards.dart';
import 'package:vocabs_flash/result.dart';
import 'package:vocabs_flash/searchInput.dart';
import 'package:vocabs_flash/localStorage/storageController.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Meaning result;
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
          synonyms: jsonData[0]['meanings'][0]['definitions'][0]
                      .containsKey('synonyms') &&
                  jsonData[0]['meanings'][0]['definitions'][0]['synonyms'].length >
                      0
              ? jsonData[0]['meanings'][0]['definitions'][0]['synonyms'].length >
                      4
                  ? jsonData[0]['meanings'][0]['definitions'][0]['synonyms']
                      .sublist(0, 4)
                  : jsonData[0]['meanings'][0]['definitions'][0]['synonyms']
              : ['No Synonyms Found'],
          example: jsonData[0]['meanings'][0]['definitions'][0].containsKey('example')
              ? jsonData[0]['meanings'][0]['definitions'][0]['example']
              : 'No Example Found',
          origin: jsonData[0]['meanings'][0].containsKey('origin') ? jsonData[0]['meanings'][0]['origin'] : 'No Origin Found');
    });
    print(result.antonyms);
  }

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('hello');
    List<FlashCardsModel> card =
        context.select((StorageController controller) => controller.user);
    print(card);
    // print('${card[0].meaning} : ${card[0].meaning}');
    print("end");

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
                  SearchInput(_searchController, getMeaning),
                  result != null ? Result(result) : Text(''),
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<StorageController>().writeUser();
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Meaning {
  final String word, audioUrl, meanings, example, origin;
  List<dynamic> antonyms, synonyms;
  Meaning(
      {this.word,
      this.meanings,
      this.audioUrl,
      this.example,
      this.synonyms,
      this.antonyms,
      this.origin});
}
