import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperIsVeren {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE isVeren(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        companyName TEXT,
        sector TEXT,
        gmail TEXT,
        password TEXT,
        lokasyon TEXT,
        vergi TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'IsVerenlers.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String companyName, String sector, String gmail,
      String password, String lokasyon, String vergi) async {
    final db = await SQLHelperIsVeren.db();
    final data = {
      'companyName': companyName,
      'sector': sector,
      'gmail': gmail,
      'password': password,
      'lokasyon': lokasyon,
      'vergi': vergi,
    };
    final id = await db.insert('isVeren', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperIsVeren.db();
    return db.query('isVeren', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperIsVeren.db();
    return db.query('isVeren', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
    int id,
    String companyName,
    String sector,
    String gmail,
    String password,
    String lokasyon,
    String vergi,
  ) async {
    final db = await SQLHelperIsVeren.db();

    final data = {
      'companyName': companyName,
      'sector': sector,
      'gmail': gmail,
      'password': password,
      'lokasyon': lokasyon,
      'vergi': vergi,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('isVeren', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperIsVeren.db();
    try {
      await db.delete("isVeren", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
