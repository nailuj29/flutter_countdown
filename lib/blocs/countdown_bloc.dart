
import 'package:countdown/database/utils.dart';
import 'package:countdown/events/countdown_event.dart';
import 'package:countdown/database/moor_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountdownBloc extends Bloc<CountdownEvent, List<Countdown>> {

  // TODO: Switch fully to moor
  @override
  List<Countdown> get initialState {
    List<Countdown> countdowns;
    //DatabaseUtils.getCountdowns().then((list) => countdowns = list);
    return countdowns;
  }
  
  // TODO: Switch fully to moor
  @override
  Stream<List<Countdown>> mapEventToState(CountdownEvent event) async* {
    switch(event.type) {
      case CountdownEventType.add:
        List<Countdown> newState = List.from(state);
        if (event.countdown != null) {
          // newState.add(event.countdown);
          // DatabaseUtils.insertCountdown(event.countdown);
        }
        yield newState;
        break;
      case CountdownEventType.delete:
        List<Countdown> newState = List.from(state);
        newState.remove(event.countdown);
        yield newState;
        break;
      case CountdownEventType.edit:
        List<Countdown> newState = List.from(state);
        newState.sort((Countdown a, Countdown b) => a.id.compareTo(b.id));
        newState[event.countdown.id] = event.countdown;
        yield newState;
        break;
      default:
        throw Exception('Event not found: $event');
    }
  } 
}