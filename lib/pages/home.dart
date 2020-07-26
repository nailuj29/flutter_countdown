import 'package:countdown/blocs/countdown_bloc.dart';
import 'package:countdown/database/moor_db.dart';
import 'package:countdown/pages/change_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  List<Countdown> countdowns;
  Home({this.countdowns});

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
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {},
          )
        ],
      ),
      body: BlocConsumer<CountdownBloc, List<Countdown>>(
        builder: (context, countdownList) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(countdownList[index].id.toString()),
                  child: ListTile(
                    leading: Container(
                      child: Column(
                        children: <Widget>[
                          Text(countdownList[index].date.month.toString(),
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          Text(countdownList[index].date.day.toString(),
                              style: TextStyle(
                                fontSize: 24,
                              ))
                        ],
                      ),
                    ),
                  ),
                  background: Container(
                    color: Colors.red,
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                );
              },
              itemCount: countdownList == null ? 0 : countdownList.length);
        },
        listener: (BuildContext context, List<Countdown> countdowns) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          CountdownBloc bloc = BlocProvider.of<CountdownBloc>(context);
          Countdown result = await Navigator.push<Countdown>(
              context,
              MaterialPageRoute(
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
