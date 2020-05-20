import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChangeEventScreen extends StatefulWidget {
  final DateTime initialDate;

  ChangeEventScreen({this.initialDate});

  @override
  State<StatefulWidget> createState() =>
      _ChangeEventScreenState(initialDate: initialDate);
}

class _ChangeEventScreenState extends State<ChangeEventScreen> {
  DateTime date;

  _ChangeEventScreenState({DateTime initialDate}) {
    date = initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Change Event"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )
        ),
      body: Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today, 
                    size: 22.0, 
                    color: Colors.black54
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    DateFormat.yMMMd(date).toString(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down, 
                    color: Colors.black54
                  )
                ],
              ),
              onPressed: () async {

                setState(() async {
                  date = await _getNewDate(date);
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Future<DateTime> _getNewDate(DateTime currentDate) async {
    DateTime _date = showDatePicker(
      context: context,
      
    )  
  }
}
