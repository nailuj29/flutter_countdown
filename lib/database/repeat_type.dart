import 'package:moor_flutter/moor_flutter.dart';

enum RepeatType { none, weekly, monthly, yearly }

extension RepeatTypeImpl on RepeatType {
  @override
  String makeString() {
    switch (this) {
      case RepeatType.none:
        return null;
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
