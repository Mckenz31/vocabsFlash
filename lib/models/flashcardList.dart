import 'package:vocabs_flash/models/flashcards.dart';

class FlassCardList {
  final List<dynamic> setNames;
  final List<FlashCardsModel> flashcards;

  FlassCardList({this.setNames, this.flashcards});

  FlassCardList.fromJson(Map<String, dynamic> json)
      : setNames = json['setNames'],
        flashcards = json['flashcards'] != null
            ? List<FlashCardsModel>.from(json['flashcards'])
            : null;

  Map<String, dynamic> toJson() => {
        'setNames': setNames,
        'flashcards': flashcards,
      };
}
