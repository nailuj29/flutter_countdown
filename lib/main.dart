import 'package:countdown/blocs/countdown_bloc.dart';
import 'package:countdown/database/moor_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:countdown/pages/home.dart';
import 'package:provider/provider.dart';

import 'blocs/countdown_bloc_delegate.dart';

void main() async {
  BlocSupervisor.delegate = CountdownBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
