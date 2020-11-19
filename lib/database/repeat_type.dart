import 'package:moor_flutter/moor_flutter.dart';

/// How often the [Countdown] will repeat.
///
/// Should never be `none` under normal circumstances.
enum RepeatType { none, weekly, monthly, yearly }

/// Provides a method to turn a [RepeatType] into a `String`.
extension RepeatTypeImpl on RepeatType {
  /// Returns a string corresponding to the value of the [RepeatType].
  String makeString() {
    switch (this) {
      case RepeatType.weekly:
        return 'Weekly';
      case RepeatType.monthly:
        return 'Monthly';
      case RepeatType.yearly:
        return 'Yearly';
      default:
        return null;
    }
  }
}

/// Converts a [RepeatType] into an `int`.
class RepeatConverter extends TypeConverter<RepeatType, int> {
  const RepeatConverter();
  static const Map<int, RepeatType> types = {
    0: RepeatType.none,
    1: RepeatType.weekly,
    2: RepeatType.monthly,
    3: RepeatType.yearly
  };

  @override
  RepeatType mapToDart(int fromDb) => types[fromDb];

  @override
  int mapToSql(RepeatType value) => types.keys
      .firstWhere((element) => types[element] == value, orElse: () => null);
}
