import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool val = Hive.box('settings').get('darkMode');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Dark mode"),
            value: val,
            onChanged: (newVal){
              setState(() {
                val = newVal;
                Hive.box('settings').put('darkMode', val);
              });
            },
          ),
        ],
      ),
    );
  }
}
