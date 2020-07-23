import 'package:countdown/events/countdown_event.dart';
import 'package:countdown/database/moor_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountdownBloc extends Bloc<CountdownEvent, List<Countdown>> {
  AppDatabase _db;
  @override
  List<Countdown> get initialState {
    _db = AppDatabase();
    _initCountdowns();

    return [];
  }

  @override
  Stream<List<Countdown>> mapEventToState(CountdownEvent event) async* {
    switch (event.type) {
      case CountdownEventType.add:
        List<Countdown> newState = List.from(state);
        if (event.countdown != null) {
          _db.insertCountdown(event.countdown);
        }
        yield newState;
        break;
      case CountdownEventType.delete:
        List<Countdown> newState = List.from(state);
        newState.remove(event.countdown);
        _db.deleteCountdown(event.countdown);
        yield newState;
        break;
      case CountdownEventType.edit:
        List<Countdown> newState = List.from(state);
        int idx =
            newState.indexWhere((element) => element.id == event.countdown.id);
        newState[idx] = event.countdown;
        _db.updateCountdown(event.countdown);
        yield newState;
        break;
      case CountdownEventType.ready:
        yield event.countdowns;
        break;
      default:
        throw Exception('Event not found: $event');
    }
  }

  _initCountdowns() async {
    List<Countdown> countdowns = await _db.getCountdowns();
    add(CountdownEvent.ready(countdowns));
  }
}
