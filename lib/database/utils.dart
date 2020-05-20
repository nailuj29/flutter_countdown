import 'package:countdown/models/countdown.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUtils {
  static final Future<Database> database = getDatabasesPath().then((path) {
    return openDatabase(
      join(path, "countdown.db"),
      onCreate: (db, version) {
        db.execute("""CREATE TABLE countdowns 
                      (id INTEGER PRIMARY KEY, 
                      date INTEGER NOT NULL, 
                      name TEXT NOT NULL)""");
      },

      version: 1
    );
  });

  static Future<void> insertCountdown(Countdown countdown) async {
    final db = await database;

    await db.insert(
      'countdowns',
      countdown.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Countdown>> getCountdowns() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query("countdowns");

    return List.generate(maps.length, (i) => Countdown(
        id: maps[i]["id"],
        date: DateTime.fromMicrosecondsSinceEpoch(maps[i]["date"]),
        name: maps[i]["name"]
      )
    );
  }
  
  static Future<void> updateCountdown(Countdown countdown) async {
    final db = await database;

    await db.update(
      "countdowns",
      countdown.toMap(),
      where: "id = ?",
      whereArgs: [countdown.id]
    );
  }

  static Future<void> deleteCountdown(Countdown countdown) async {
    final db = await database;

    await db.delete(
      "countdowns",
      where: "id = ?",
      whereArgs: [countdown.id]
    );
  }

}