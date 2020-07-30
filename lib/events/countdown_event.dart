import 'package:countdown/database/moor_db.dart';

@deprecated
enum CountdownEventType {
  add,
  edit,
  delete,
  ready,
}

@deprecated
class CountdownEvent {
  Countdown countdown;
  CountdownsCompanion companion;
  List<Countdown> countdowns;
  CountdownEventType type;

  CountdownEvent.add(CountdownsCompanion countdown) {
    this.companion = countdown;
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
