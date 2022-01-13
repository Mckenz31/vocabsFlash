class FlashCardsModel {
  final String word;
  final String meaning;
  final List setName;
  // final String audioUrl;
  // final List<String> synonyms;
  // final List<String> antonyms;
  FlashCardsModel({this.word, this.meaning, this.setName});

  // FlashCardsModel.fromJson(Map<String, dynamic> json)
  //     : word = json['word'],
  //       meaning = json['meaning'],
  //       setName = json['setName'];

  factory FlashCardsModel.fromJson(Map<String, dynamic> json) =>
      FlashCardsModel(
          word: json['word'],
          meaning: json['meaning'],
          setName: json['setName']);

  Map<String, dynamic> toJson() => {
        'word': word,
        'meaning': meaning,
        'setName': setName,
      };
}
