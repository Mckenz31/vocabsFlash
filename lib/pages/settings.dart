import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool val = Hive.box('settings').get('darkMode', defaultValue: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 25,),
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
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("About",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showAboutDialog(
                        context: context,
                        applicationName: "vocabs_flash",
                        applicationLegalese:
                        "Fun and effective way to learn vocabulary\n\n\n");
                  },
                  icon: Icon(Icons.info_outline),
                  color: val ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
