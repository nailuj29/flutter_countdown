import 'package:countdown/database/repeat_type.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'moor_db.g.dart';

class Countdowns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  DateTimeColumn get date => dateTime()();
  BoolColumn get repeats => boolean().withDefault(Constant(false))();
  IntColumn get repeatType =>
      integer().map(const RepeatConverter()).nullable()();
}

@UseMoor(tables: [Countdowns])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: "countdowns.db", logStatements: true));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1 && to == 2) {
          await m.addColumn(countdowns, countdowns.repeats);
          await m.addColumn(countdowns, countdowns.repeatType);
        }
      });

  // Create
  Future<int> insertCountdown(CountdownsCompanion countdown) =>
      into(countdowns).insert(countdown);

  // Read
  Future<List<Countdown>> getCountdowns() => select(countdowns).get();
  Stream<List<Countdown>> watchCountdowns() => select(countdowns).watch();
  Stream<List<Countdown>> watchCountdownsByDate() => (select(countdowns)
        ..orderBy([(countdown) => OrderingTerm(expression: countdown.date)]))
      .watch();

  // Update
  Future<bool> updateCountdown(Countdown countdown) =>
      update(countdowns).replace(countdown);

  // Delete
  Future<int> deleteCountdown(Countdown countdown) =>
      delete(countdowns).delete(countdown);
}
