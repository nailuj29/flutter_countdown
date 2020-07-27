import 'package:countdown/database/moor_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChangeEventScreen extends StatefulWidget {
  DateTime initialDate;
  Countdown countdown;

  ChangeEventScreen({this.initialDate, this.countdown}) {
    if (initialDate != null && countdown != null) {
      throw Exception(
          "Cannot pass both countdown and initialDate to constructor");
    }
    if (countdown != null) {
      initialDate = countdown.date;
    } else if (initialDate != null) {
      countdown = Countdown(date: initialDate);
    }
  }

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
          )),
      body: Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(10.0),
              color: Colors.grey[300],
              child: Row(
                children: <Widget>[
                  Icon(Icons.calendar_today, size: 22.0, color: Colors.black54),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    DateFormat.yMMMd().format(date),
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
              onPressed: () async {
                setDate();
              },
            )
          ],
        ),
        padding: EdgeInsets.all(16.0),
      ),
    );
  }

  Future<DateTime> _getNewDate(DateTime currentDate) async {
    DateTime _date = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate.subtract(Duration(days: 365)),
        lastDate: currentDate.add(Duration(days: 365 * 5)));
    if (_date == null) {
      return currentDate;
    }
    return _date;
  }

  setDate() async {
    DateTime _date = await _getNewDate(date);
    setState(() {
      date = _date;
    });
  }
}
