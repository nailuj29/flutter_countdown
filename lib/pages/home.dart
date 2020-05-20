import 'package:countdown/blocs/countdown_bloc.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState(CountdownBloc countdownBloc) => _HomeState(countdownBloc);
}

class _HomeState extends State<Home> {
  String _name = "Text";
  DateTime _date = DateTime.utc(2020, 6, 29);
  CountdownBloc countdownBloc;
  _HomeState(CountdownBloc countdownBloc);
  
  @override
  Widget build(BuildContext context) {
    // One day gets rounded off
    int _difference = _date.difference(DateTime.now()).inDays + 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countdown"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings), 
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.calendar_today), 
            onPressed:  () {},
          )
        ],
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
               _difference.toString(),
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.black54
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              "days left until",
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 20.0),
            Text(
              _name,
              style: TextStyle(fontSize: 21.0),
            ),
          ],
        ),
      ),
    );
  }
}
