import 'package:flutter/material.dart';
import 'package:flacabulary/models/vocabSet_model.dart';
import 'package:flacabulary/pages/settings.dart';
import 'package:flacabulary/pages/vocabsets.dart';
import 'pages/intoductionpage.dart';
import 'package:flutter/foundation.dart';
import 'package:flacabulary/pages/practicecards.dart';
import 'pages/landingpage.dart';
import 'pages/search.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'models/vocabSet_model.dart';
import 'providers/hivenewset_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  Hive.registerAdapter(VocabSetModelAdapter());
  await Hive.openBox('settings');
  runApp(
    ChangeNotifierProvider(
      create: (context) => HiveNewSet(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool val = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: val ? Hive.openBox<VocabSetModel>(Provider.of<HiveNewSet>(context).hiveBox) : Hive.openBox(Provider.of<HiveNewSet>(context).hiveBox),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final generateBoxes =Hive.box('vocabSets');
          for(int i=0; i<generateBoxes.length; i++){
            Hive.openBox<VocabSetModel>(generateBoxes.getAt(i));
            print(generateBoxes.getAt(i));
          }
          val = true;
        }
        return ValueListenableBuilder(
          valueListenable: Hive.box('settings').listenable(),
          builder: (context, Box box, builder){
            var darkMode = box.get('darkMode', defaultValue: false);
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: darkMode ? ThemeData.dark() : ThemeData.light(),
              routes: {
                '/': (context) => IntroductionPage(),
                '/landingPage' : (context) => LandingPage(),
                '/vocabSets' : (context) => VocabSets(),
                // '/flashCards': (context) => FlashCards(),
                '/search': (context) => Search(),
                '/practiceCards': (context) => PracticeCards(),
                '/settings' : (context) => Settings()
              },
              initialRoute: Hive.box('settings').get('firstTime') != false
                ? '/'
                : '/landingPage',
            );
          },
        );
      },
    );
  }
}
