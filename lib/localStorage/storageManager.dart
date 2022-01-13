import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:vocabs_flash/models/flashcardList.dart';
import 'package:vocabs_flash/models/flashcards.dart';

class StorageManager {
  static StorageManager _instance;

  StorageManager._internal() {
    _instance = this;
  }

  factory StorageManager() => _instance ?? StorageManager._internal();

  Future<String> get _directoryPath async {
    Directory directory = await getExternalStorageDirectory();
    return directory.path;
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File('$path/flashcard.json');
  }

  Future<List<FlashCardsModel>> readJsonFile() async {
    String fileContent = 'Cheetah Coding';

    File file = await _jsonFile;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
        return json.decode(fileContent);
      } catch (e) {
        print(e);
      }
    }

    return null;
  }

  Future<List<FlashCardsModel>> writeJsonFile() async {
    List<FlashCardsModel> list = [];

    final FlashCardsModel card = FlashCardsModel(
        word: 'hello', meaning: 'Greetings', setName: ['set 1', 'set 2']);
        
    list.add(card);

    File file = await _jsonFile;
    await file.writeAsString(json.encode(list));
    return list;
  }

  deleteJson() async {
    File file = await _jsonFile;
    if (await file.exists()) {
      await file.delete();
    }
  }
}
