import 'package:countdown/blocs/countdown_bloc.dart';
import 'package:countdown/database/moor_db.dart';
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
    // One day gets rounded off
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
            onPressed:  () {},
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
                  // TODO: Finish ListTile widget.
                ),
                background: Container(
                  color: Colors.red,
                  
                ),
              );
            }, 
            separatorBuilder: null, 
            itemCount: countdownList.length
          );
        },
        listener: (BuildContext context, List<Countdown> countdowns) {},
      )
    );
  }
}
