import 'package:moor_flutter/moor_flutter.dart';

part 'moor_db.g.dart';

class Countdowns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  DateTimeColumn get date => dateTime()();
}

@UseMoor(tables: [Countdowns])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "countdowns.db", logStatements: true));

  @override
  int get schemaVersion => 1;

  // Create
  Future<int> insertCountdown(Countdown countdown) =>
      into(countdowns).insert(countdown);

  // Read
  Future<List<Countdown>> getCountdowns() => select(countdowns).get();
  Stream<List<Countdown>> watchCountdowns() => select(countdowns).watch();

  // Update
  Future<bool> updateCountdown(Countdown countdown) =>
      update(countdowns).replace(countdown);

  // Delete
  Future<int> deleteCountdown(Countdown countdown) =>
      delete(countdowns).delete(countdown);
}
