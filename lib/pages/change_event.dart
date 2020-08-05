import 'package:countdown/database/moor_db.dart';
import 'package:eyro_toast/eyro_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
      _countdown = null;
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
  CountdownsCompanion companion = CountdownsCompanion();
  TextEditingController controller;

  bool get isNew => countdown == null;

  _ChangeEventScreenState({this.dateSet, this.countdown})
      : controller = TextEditingController() {
    if (countdown != null) {
      controller.text = countdown.name;
    }
    print(isNew);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
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
            RaisedButton(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    size: 22.0,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    DateFormat.yMMMd().format(dateSet),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                  )
                ],
              ),
              onPressed: () async {
                await setDate();
                if (isNew) {
                  companion = CountdownsCompanion.insert(
                      name: companion.name.value, date: dateSet);
                } else {
                  countdown = Countdown(
                      date: dateSet, name: countdown.name, id: countdown.id);
                }
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
            ),
            SizedBox(
              height: 100.0,
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text("Save"),
                  onPressed: () async {
                    if (controller.text == null || controller.text.isEmpty) {
                      // await Fluttertoast.showToast(
                      //     msg: "You must enter a name",
                      //     toastLength: Toast.LENGTH_SHORT,
                      //     gravity: ToastGravity.BOTTOM,
                      //     timeInSecForIosWeb: 1,
                      //     backgroundColor: Color(0xEEFFFFFF),
                      //     textColor: Colors.black);
                      await EyroToast.showToast(
                          text: "You must enter a name",
                          duration: ToastDuration.short);
                      print("Cannot submit");
                      return;
                    }
                    if (isNew) {
                      companion = CountdownsCompanion.insert(
                          date: dateSet, name: controller.text);
                      database.insertCountdown(companion);
                    } else {
                      countdown = Countdown(
                          id: countdown.id,
                          date: dateSet,
                          name: controller.text);
                      database.updateCountdown(countdown);
                    }

                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
