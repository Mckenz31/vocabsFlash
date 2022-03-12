import 'package:flutter/material.dart';

class flashCardChange extends ChangeNotifier {
  Color _color1 = Colors.deepOrange;
  Color _color2 = Colors.red;
  Color _color;

  Color get getColor {
    return _color;
  }

  void changeColor() {
    if(_color == _color1){
      _color = _color2;
    }
    else{
      _color = _color1;
    }
    notifyListeners();
  }
}