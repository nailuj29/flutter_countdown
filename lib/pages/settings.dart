import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: PreferencePage([
          PreferenceTitle("General"),
          SwitchPreference(
              "Auto-delete past countdowns", "delete_past_countdowns"),
        ]));
  }
}
