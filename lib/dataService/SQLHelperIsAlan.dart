import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperIsAlan {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE ısAlan(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        surName TEXT,
        gmail TEXT,
        password TEXT,
        ilgiAlan TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'IsAlanlar.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String name, String surName, String gmail,
      String password, String Alan) async {
    final db = await SQLHelperIsAlan.db();
    final data = {
      'name': name,
      'surName': surName,
      'gmail': gmail,
      'password': password,
      'ilgiAlan': Alan,
    };
    final id = await db.insert('ısAlan', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperIsAlan.db();
    return db.query('ısAlan', orderBy: "id");
  }

  static Future<int> updateItem(
    int id,
    String name,
    String surName,
    String gmail,
    String password,
    String Alan,
  ) async {
    final db = await SQLHelperIsAlan.db();

    final data = {
      'name': name,
      'surName': surName,
      'gmail': gmail,
      'password': password,
      'ilgiAlan': Alan,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('ısAlan', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperIsAlan.db();
    try {
      await db.delete("ısAlan", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
