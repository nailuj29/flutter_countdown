import 'package:countdown/blocs/countdown_bloc.dart';
import 'package:countdown/database/moor_db.dart';
import 'package:countdown/pages/change_event.dart';
import 'package:countdown/events/countdown_event.dart';
import 'package:countdown/shared/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countdown"),
        actions: <Widget>[
          /* IconButton(
            icon: Icon(Icons.settings), 
            onPressed: () {},
          ), */
        ],
      ),
      body: BlocConsumer<CountdownBloc, List<Countdown>>(
        builder: (context, countdownList) {
          return ListView.separated(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (context, index) {
                int _daysRemaining =
                    countdownList[index].date.difference(DateTime.now()).inDays;
                return Dismissible(
                  key: Key(countdownList[index].id.toString()),
                  onDismissed: (direction) {
                    CountdownBloc bloc = BlocProvider.of(context);
                    bloc.add(CountdownEvent.delete(countdownList[index]));
                  },
                  child: ListTile(
                    leading: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Text(DateUtils.month(countdownList[index].date),
                            style: TextStyle(
                              fontSize: 12,
                            )),
                        Text(DateUtils.day(countdownList[index].date),
                            style: TextStyle(
                              fontSize: 24,
                            ))
                      ],
                    ),
                    title: Container(
                      child: Text(_daysRemaining > 0
                          ? "${_daysRemaining + 1} day${_daysRemaining == 1 ? "" : "s"} until ${countdownList[index].name}"
                          : _daysRemaining == 0
                              ? "${countdownList[index].name} is today! 🎉"
                              : "${countdownList[index].name} was ${_daysRemaining.abs()} day${_daysRemaining == -1 ? "" : "s"} ago"),
                    ),
                  ),
                  background: Container(
                    color: Colors.red,
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
                return Divider(color: Colors.grey[800]);
              },
              itemCount: countdownList == null ? 0 : countdownList.length);
        },
        listener: (BuildContext context, List<Countdown> countdowns) {},
      ),
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
