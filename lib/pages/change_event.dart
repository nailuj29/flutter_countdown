import 'package:countdown/database/moor_db.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ChangeEventScreen extends StatefulWidget {
  DateTime initialDate;
  Countdown countdown;

  ChangeEventScreen({DateTime initialDate, Countdown countdown}) {
    Countdown _countdown;
    DateTime _initialDate;
    if (initialDate != null && countdown != null) {
      throw Exception(
          "Cannot pass both countdown and initialDate to constructor");
    }
    if (countdown != null) {
      _initialDate = countdown.date;
      _countdown = countdown;
    } else if (initialDate != null) {
      // ignore: missing_required_param
      _countdown = Countdown(date: initialDate);
      _initialDate = initialDate;
    }
    this.countdown = _countdown;
    this.initialDate = _initialDate;
  }

  @override
  State<StatefulWidget> createState() =>
      _ChangeEventScreenState(dateSet: initialDate, countdown: countdown);
}

class _ChangeEventScreenState extends State<ChangeEventScreen> {
  DateTime dateSet;
  Countdown countdown;
  TextEditingController controller;

  _ChangeEventScreenState({this.dateSet, this.countdown})
      : controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Change Event"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop<Countdown>(null),
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
                    DateFormat.yMMMd().format(dateSet),
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.black54)
                ],
              ),
              onPressed: () async {
                setDate();
              },
            ),
            Row(
              children: <Widget>[
                Text("Event Name:"),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                  ),
                )
              ],
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
    DateTime _date = await _getNewDate(dateSet);
    setState(() {
      dateSet = _date;
    });
  }
}
