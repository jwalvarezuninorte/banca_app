import 'package:banca_app/backend/models/credit.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService extends ChangeNotifier {
  Future<Database>? database;

  initCreditHistoryDatabase() async {
    database = await createDatabase();
    return database;
  }

  static Future<Future<Database>> createDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'credits_history_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE credits_history(id INTEGER PRIMARY KEY, userId INTEGER, nQuota INTEGER, simulationDate TEXT, creditTypeName TEXT, creditTypeInterest REAL, totalLoan REAL)",
        );
      },
      version: 1,
    );
  }

  Future<void> saveCredit(Credit credit) async {
    final Database db = await database as Database;

    await db.insert(
      'credits_history',
      credit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Credit>> getSavedCredits({
    required int userId,
  }) async {
    final Database db = await database as Database;

    final List<Map<String, Object?>> queryResult = await db.query(
      'credits_history',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return queryResult.map((e) => Credit.fromMap(e)).toList();
  }
}
