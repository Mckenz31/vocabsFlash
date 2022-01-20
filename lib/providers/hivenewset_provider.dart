import 'package:flutter/material.dart';

class HiveNewSet with ChangeNotifier {

  String _hiveBox = 'vocabSets';

  String get hiveBox => _hiveBox;

  void newBox(String boxName){
    _hiveBox = boxName;
    notifyListeners();
  }

}