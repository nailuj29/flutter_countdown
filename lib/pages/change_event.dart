import 'package:countdown/database/moor_db.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
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
  DateTime initialDate;
  Countdown countdown;
  CountdownsCompanion companion = CountdownsCompanion();
  TextEditingController controller;

  bool get isNew => countdown == null;

  _ChangeEventScreenState({this.initialDate, this.countdown})
      : controller = TextEditingController() {
    if (countdown != null) {
      controller.text = countdown.name;
    }
    print(isNew);
  }
  final _formKey = GlobalKey<FormState>();
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
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DateTimeField(
                validator: (val) =>
                    val == null ? 'You must enter a date' : null,
                initialValue: isNew ? initialDate : countdown.date,
                format: DateFormat.yMMMd(),
                onShowPicker: (context, currentValue) async {
                  final result = await _getNewDate(currentValue);
                  if (isNew) {
                    companion = CountdownsCompanion.insert(
                        name: companion.name.value, date: result);
                  } else {
                    countdown = Countdown(
                        date: result, name: countdown.name, id: countdown.id);
                  }
                  return result;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: (val) =>
                    val.isEmpty ? 'You must enter a name' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                controller: controller,
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Save"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            if (isNew) {
                              companion = CountdownsCompanion.insert(
                                  date: dateSet, name: controller.text);
                              await database.insertCountdown(companion);
                            } else {
                              countdown = Countdown(
                                  id: countdown.id,
                                  date: dateSet,
                                  name: controller.text);
                              await database.updateCountdown(countdown);
                            }

                            Navigator.of(context).pop();
                          }
                        },
                      ),
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
