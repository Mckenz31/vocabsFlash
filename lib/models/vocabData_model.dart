import 'package:hive/hive.dart';

part 'vocabData_model.g.dart';

@HiveType(typeId: 0)
class VocabData {
  @HiveField(0)
  String word;

  @HiveField(1)
  bool learnt;

  @HiveField(2)
  bool inProcess;

  @HiveField(3)
  bool inComplete;

  @HiveField(4)
  String meaning;

  @HiveField(5)
  String example;

  @HiveField(6)
  String audioURL;

  @HiveField(7)
  List<String> synonym;

  @HiveField(8)
  List<String> antonym;

  VocabData(
      {this.word,
      this.learnt,
      this.inProcess,
      this.inComplete,
      this.meaning,
      this.example,
      this.audioURL,
      this.antonym,
      this.synonym});
}
