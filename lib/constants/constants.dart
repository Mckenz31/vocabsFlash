import 'package:vocabs_flash/constants/card_model.dart';

class Constants {
  var value = [
    {
      "word": "hello",
      "phonetics": [
        {
          "text": "/həˈloʊ/",
          "audio": "https://lex-audio.useremarkable.com/mp3/hello_us_1_rr.mp3"
        },
        {
          "text": "/hɛˈloʊ/",
          "audio": "https://lex-audio.useremarkable.com/mp3/hello_us_2_rr.mp3"
        }
      ],
      "meanings": [
        {
          "partOfSpeech": "exclamation",
          "definitions": [
            {
              "definition":
                  "Used as a greeting or to begin a phone conversation.",
              "example": "hello there, Katie!"
            }
          ]
        },
        {
          "partOfSpeech": "noun",
          "definitions": [
            {
              "definition": "An utterance of “hello”; a greeting.",
              "example": "she was getting polite nods and hellos from people",
              "synonyms": [
                "greeting",
                "welcome",
                "salutation",
                "saluting",
                "hailing",
                "address",
                "hello",
                "hallo"
              ]
            }
          ]
        },
        {
          "partOfSpeech": "intransitive verb",
          "definitions": [
            {
              "definition": "Say or shout “hello”; greet someone.",
              "example": "I pressed the phone button and helloed"
            }
          ]
        }
      ]
    }
  ];

  List<CardModel> cardz = [
    CardModel(title: "GRE words", learnt: 10, inProcess: 10, incomplete: 10, progressVal: 0.3),
    CardModel(title: "TOEFL words", learnt: 15, inProcess: 8, incomplete: 7, progressVal: 0.5),
    CardModel(title: "IELTS words", learnt: 20, inProcess: 5, incomplete: 5, progressVal: 0.7),
    CardModel(title: "SAT words", learnt: 19, inProcess: 3, incomplete: 8, progressVal: 0.6),
    CardModel(title: "GMAT words", learnt: 5, inProcess: 10, incomplete: 15, progressVal: 0.17),
  ];

}
