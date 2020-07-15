import 'package:countdown/database/moor_db.dart';

enum CountdownEventType {
  add,
  edit,
  delete,
  ready,
}

class CountdownEvent {
  Countdown countdown;
  List<Countdown> countdowns;
  CountdownEventType type;

  CountdownEvent.add(Countdown countdown) {
    this.countdown = countdown;
    this.type = CountdownEventType.add;
  }

  CountdownEvent.edit(Countdown countdown) {
    this.countdown = countdown;
    this.type = CountdownEventType.edit;
  }

  CountdownEvent.delete(Countdown countdown) {
    this.countdown = countdown;
    this.type = CountdownEventType.delete;
  }

  CountdownEvent.ready(List<Countdown> countdowns) {
    this.countdowns = countdowns;
    this.type = CountdownEventType.ready;
  }
}
