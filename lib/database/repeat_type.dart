import 'package:moor_flutter/moor_flutter.dart';

enum RepeatType { none, weekly, monthly, yearly }

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
