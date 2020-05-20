import 'package:countdown/blocs/countdown_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:countdown/pages/home.dart';

import 'blocs/countdown_bloc_delegate.dart';

void main() async { 
  BlocSupervisor.delegate = CountdownBlocDelegate();
  runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CountdownBloc>(
      create: (context) => CountdownBloc(),
      child: MaterialApp(
        title: "Countdown",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal.shade500,
        ),
        home: Home(),
      ),
    );
  }

}