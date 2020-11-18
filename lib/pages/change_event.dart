import 'package:countdown/database/moor_db.dart';
import 'package:countdown/database/repeat_type.dart';
import 'package:countdown/shared/string_to_repeat_type.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
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
  bool repeats = false;
  RepeatType type = RepeatType.none;
  CountdownsCompanion companion = CountdownsCompanion();
  TextEditingController controller;

  bool get isNew => countdown == null;

  _ChangeEventScreenState({this.dateSet, this.countdown})
      : controller = TextEditingController() {
    if (countdown != null) {
      controller.text = countdown.name;
      repeats = countdown.repeats;
      type = countdown.repeatType;
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
                initialValue: isNew ? DateTime.now() : countdown.date,
                format: DateFormat.yMMMd(),
                onShowPicker: (context, currentValue) async {
                  final result = await _getNewDate(currentValue);
                  if (isNew) {
                    companion = CountdownsCompanion.insert(
                        name: companion.name.value, date: result);
                  } else {
                    countdown = Countdown(
                        date: result,
                        name: countdown.name,
                        id: countdown.id,
                        repeats: countdown.repeats);
                  }
                  dateSet = result;
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
              FormField(builder: (field) {
                return CheckboxListTile(
                  value: repeats,
                  onChanged: (val) {
                    setState(() {
                      repeats = val;
                    });
                  },
                  title: Text('Repeats'),
                );
              }),
              DropdownButtonFormField(
                items: ['Weekly', 'Monthly', 'Yearly']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: repeats
                    ? (String val) {
                        setState(() {
                          type = val.toRepeatType();
                        });
                      }
                    : null,
                value: type.makeString(),
                decoration: InputDecoration(
                    labelText: 'Repeat Interval', border: OutlineInputBorder()),
                validator: (String value) {
                  if (repeats && (value == null || value.isEmpty)) {
                    return 'You must choose a repeat interval if the countdown repeats.';
                  }
                  return null;
                },
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
                                  date: dateSet,
                                  name: controller.text,
                                  repeats: Value(repeats),
                                  repeatType: Value(type));
                              await database.insertCountdown(companion);
                            } else {
                              countdown = Countdown(
                                  id: countdown.id,
                                  date: dateSet,
                                  name: controller.text,
                                  repeats: repeats,
                                  repeatType: type);
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
    DateTime initialDate = currentDate ?? DateTime.now();
    DateTime _date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: initialDate.subtract(Duration(days: 365)),
        lastDate: initialDate.add(Duration(days: 365 * 5)));
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
