import 'package:flutter/material.dart';
import 'package:vocabs_flash/localStorage/storageManager.dart';
import 'package:vocabs_flash/models/flashcardList.dart';
import 'package:vocabs_flash/models/flashcards.dart';

class StorageController extends ChangeNotifier {
  // FlashCardsModel _user;

  List<FlashCardsModel> list;
  // FlassCardList _flashcards;
  // FlassCardList get user => _flashcards;
  List<FlashCardsModel> get user => list;

  readUser() async {
    final result = await StorageManager().readJsonFile();

    if (result != null) {
      // _user = FlashCardsModel.fromJson(await StorageManager().readJsonFile());
      list = await StorageManager().readJsonFile();
    }

    notifyListeners();
  }

  writeUser() async {
    // _user = await StorageManager().writeJsonFile();
    list = await StorageManager().writeJsonFile();
    notifyListeners();
  }

  deleteUser() async {
    await StorageManager().deleteJson();
    notifyListeners();
  }
}
