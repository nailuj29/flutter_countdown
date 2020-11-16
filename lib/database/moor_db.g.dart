// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Countdown extends DataClass implements Insertable<Countdown> {
  final int id;
  final String name;
  final DateTime date;
  final bool repeats;
  final RepeatType repeatType;
  Countdown(
      {@required this.id,
      @required this.name,
      @required this.date,
      @required this.repeats,
      this.repeatType});
  factory Countdown.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Countdown(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
      repeats:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}repeats']),
      repeatType: $CountdownsTable.$converter0.mapToDart(intType
          .mapFromDatabaseResponse(data['${effectivePrefix}repeat_type'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || repeats != null) {
      map['repeats'] = Variable<bool>(repeats);
    }
    if (!nullToAbsent || repeatType != null) {
      final converter = $CountdownsTable.$converter0;
      map['repeat_type'] = Variable<int>(converter.mapToSql(repeatType));
    }
    return map;
  }

  CountdownsCompanion toCompanion(bool nullToAbsent) {
    return CountdownsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      repeats: repeats == null && nullToAbsent
          ? const Value.absent()
          : Value(repeats),
      repeatType: repeatType == null && nullToAbsent
          ? const Value.absent()
          : Value(repeatType),
    );
  }

  factory Countdown.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Countdown(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime>(json['date']),
      repeats: serializer.fromJson<bool>(json['repeats']),
      repeatType: serializer.fromJson<RepeatType>(json['repeatType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime>(date),
      'repeats': serializer.toJson<bool>(repeats),
      'repeatType': serializer.toJson<RepeatType>(repeatType),
    };
  }

  Countdown copyWith(
          {int id,
          String name,
          DateTime date,
          bool repeats,
          RepeatType repeatType}) =>
      Countdown(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        repeats: repeats ?? this.repeats,
        repeatType: repeatType ?? this.repeatType,
      );
  @override
  String toString() {
    return (StringBuffer('Countdown(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('repeats: $repeats, ')
          ..write('repeatType: $repeatType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(name.hashCode,
          $mrjc(date.hashCode, $mrjc(repeats.hashCode, repeatType.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Countdown &&
          other.id == this.id &&
          other.name == this.name &&
          other.date == this.date &&
          other.repeats == this.repeats &&
          other.repeatType == this.repeatType);
}

class CountdownsCompanion extends UpdateCompanion<Countdown> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> date;
  final Value<bool> repeats;
  final Value<RepeatType> repeatType;
  const CountdownsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.repeats = const Value.absent(),
    this.repeatType = const Value.absent(),
  });
  CountdownsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required DateTime date,
    this.repeats = const Value.absent(),
    this.repeatType = const Value.absent(),
  })  : name = Value(name),
        date = Value(date);
  static Insertable<Countdown> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<DateTime> date,
    Expression<bool> repeats,
    Expression<int> repeatType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (repeats != null) 'repeats': repeats,
      if (repeatType != null) 'repeat_type': repeatType,
    });
  }

  CountdownsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<DateTime> date,
      Value<bool> repeats,
      Value<RepeatType> repeatType}) {
    return CountdownsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      repeats: repeats ?? this.repeats,
      repeatType: repeatType ?? this.repeatType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (repeats.present) {
      map['repeats'] = Variable<bool>(repeats.value);
    }
    if (repeatType.present) {
      final converter = $CountdownsTable.$converter0;
      map['repeat_type'] = Variable<int>(converter.mapToSql(repeatType.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountdownsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('repeats: $repeats, ')
          ..write('repeatType: $repeatType')
          ..write(')'))
        .toString();
  }
}

class $CountdownsTable extends Countdowns
    with TableInfo<$CountdownsTable, Countdown> {
  final GeneratedDatabase _db;
  final String _alias;
  $CountdownsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 100);
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _repeatsMeta = const VerificationMeta('repeats');
  GeneratedBoolColumn _repeats;
  @override
  GeneratedBoolColumn get repeats => _repeats ??= _constructRepeats();
  GeneratedBoolColumn _constructRepeats() {
    return GeneratedBoolColumn('repeats', $tableName, false,
        defaultValue: Constant(false));
  }

  final VerificationMeta _repeatTypeMeta = const VerificationMeta('repeatType');
  GeneratedIntColumn _repeatType;
  @override
  GeneratedIntColumn get repeatType => _repeatType ??= _constructRepeatType();
  GeneratedIntColumn _constructRepeatType() {
    return GeneratedIntColumn(
      'repeat_type',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, date, repeats, repeatType];
  @override
  $CountdownsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'countdowns';
  @override
  final String actualTableName = 'countdowns';
  @override
  VerificationContext validateIntegrity(Insertable<Countdown> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('repeats')) {
      context.handle(_repeatsMeta,
          repeats.isAcceptableOrUnknown(data['repeats'], _repeatsMeta));
    }
    context.handle(_repeatTypeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Countdown map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Countdown.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CountdownsTable createAlias(String alias) {
    return $CountdownsTable(_db, alias);
  }

  static TypeConverter<RepeatType, int> $converter0 = const RepeatConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CountdownsTable _countdowns;
  $CountdownsTable get countdowns => _countdowns ??= $CountdownsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [countdowns];
}
