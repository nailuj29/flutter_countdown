import 'package:countdown/database/moor_db.dart';
import 'package:flutter/material.dart';
import 'package:countdown/pages/home.dart';
import 'package:preferences/preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  await PrefService.init(prefix: "countdown_");
  runApp(CountdownApp());
}

class CountdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => AppDatabase(),
        child: MaterialApp(
          title: "Countdown",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.teal.shade500,
          ),
          home: Home(),
        ));
  }
}
