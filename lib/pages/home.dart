import 'package:countdown/database/moor_db.dart';
import 'package:countdown/database/repeat_type.dart';
import 'package:countdown/pages/change_event.dart';
import 'package:countdown/pages/settings.dart';
import 'package:countdown/shared/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Countdown deletedCountdown;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Countdown"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SettingsPage())),
          ),
        ],
      ),
      body: StreamBuilder<List<Countdown>>(
          stream: database.watchCountdownsByDate(),
          builder: (context, snapshot) {
            final countdownList = snapshot.data;

            return countdownList == null
                ? Center(
                    child: CircularProgressIndicator(
                      value: null,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      final countdown = countdownList[index];
                      final countdownDate = DateTime(countdown.date.year,
                          countdown.date.month, countdown.date.day);
                      DateTime todaysDate = DateTime.now();
                      todaysDate = DateTime(
                          todaysDate.year, todaysDate.month, todaysDate.day);
                      int _daysRemaining =
                          countdownDate.difference(todaysDate).inDays;
                      if (_daysRemaining <= -1 &&
                          PrefService.getBool("delete_past_countdowns")) {
                        if (countdown.repeats) {
                          Countdown newCountdown;
                          switch (countdown.repeatType) {
                            case RepeatType.none:
                              newCountdown = countdown;
                              break;
                            case RepeatType.weekly:
                              newCountdown = countdown.copyWith(
                                  date: countdownDate.add(Duration(days: 7)));
                              break;
                            case RepeatType.monthly:
                              var newDate = DateTime(
                                  countdownDate.year +
                                      (countdownDate.month == 12 ? 1 : 0),
                                  countdownDate.month == 12
                                      ? 1
                                      : countdownDate.month + 1,
                                  countdownDate.day);
                              newCountdown = countdown.copyWith(date: newDate);
                              break;
                            case RepeatType.yearly:
                              var newDate = DateTime(countdownDate.year + 1,
                                  countdownDate.month, countdownDate.day);
                              newCountdown = countdown.copyWith(date: newDate);
                              break;
                          }
                          database.updateCountdown(newCountdown);
                        } else {
                          database.deleteCountdown(countdown);
                        }
                      }

                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          database.deleteCountdown(countdown);
                          deletedCountdown = countdown;
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Countdown ${deletedCountdown.name} deleted.'),
                              action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    database.insertCountdown(
                                        deletedCountdown.toCompanion(true));
                                  })));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            leading: Container(
                              width: 50,
                              color: Theme.of(context).backgroundColor.red > 120
                                  ? Colors.grey[300]
                                  : Colors.grey[800],
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 6.0),
                                  Text(DateUtils.month(countdown.date),
                                      style: TextStyle(
                                        fontSize: 12,
                                      )),
                                  Text(DateUtils.day(countdown.date),
                                      style: TextStyle(
                                        fontSize: 24,
                                      ))
                                ],
                              ),
                            ),
                            title: Container(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Text(_daysRemaining > 0
                                  ? "$_daysRemaining day${_daysRemaining == 1 ? "" : "s"} until ${countdown.name}"
                                  : _daysRemaining == 0
                                      ? countdown.name
                                              .toLowerCase()
                                              .contains('birthday')
                                          ? "${countdown.name} is today! 🎉 (Happy Birthday!)"
                                          : countdown.date.day == 31 &&
                                                  countdown.date.month ==
                                                      10 // Halloween
                                              ? "${countdown.name} is today! 🎃"
                                              // TODO: add holiday messages for other holdiays where the date differs like Thanksgiving and Hanukkah
                                              : countdown.date.day == 25 &&
                                                      countdown.date.month == 12
                                                  ? "${countdown.name} is today! 🎄"
                                                  : "${countdown.name} is today! 🎉"
                                      : "${countdown.name} was ${_daysRemaining.abs()} day${_daysRemaining == -1 ? "" : "s"} ago"),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return ChangeEventScreen(
                                    countdown: countdown,
                                  );
                                },
                              ));
                            },
                          ),
                        ),
                        background: Container(
                          alignment: AlignmentDirectional.centerStart,
                          color: Colors.red,
                          child: Icon(Icons.delete_outline),
                          padding: EdgeInsets.all(16.0),
                        ),
                        secondaryBackground: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          color: Colors.red,
                          child: Icon(Icons.delete_outline),
                          padding: EdgeInsets.all(16.0),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                          color: Theme.of(context).backgroundColor.red > 120
                              ? Colors.grey[400]
                              : Colors.grey[900],
                          height: 1);
                    },
                    itemCount:
                        countdownList == null ? 0 : countdownList.length);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChangeEventScreen(
              initialDate: DateTime.now(),
            ),
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
