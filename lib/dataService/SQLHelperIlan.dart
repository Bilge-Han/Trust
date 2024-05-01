import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperIlan {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE ilanlar(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        companyid INTEGER,
        companyName TEXT,
        sector TEXT,
        alan TEXT,
        lokasyon TEXT,
        kriter TEXT,
        tarih TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('Ilanlarr.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(
      int companyid,
      String companyName,
      String sector,
      String alan,
      String lokasyon,
      String kriter,
      String tarih) async {
    final db = await SQLHelperIlan.db();
    final data = {
      'companyid': companyid,
      'companyName': companyName,
      'sector': sector,
      'alan': alan,
      'lokasyon': lokasyon,
      'kriter': kriter,
      'tarih': tarih,
    };
    final id = await db.insert('ilanlar', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperIlan.db();
    return db.query('ilanlar', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperIlan.db();
    return db.query('ilanlar', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id,
      int companyid,
      String companyName,
      String sector,
      String alan,
      String lokasyon,
      String kriter,
      String tarih) async {
    final db = await SQLHelperIlan.db();
    final data = {
      'companyid': companyid,
      'companyName': companyName,
      'sector': sector,
      'alan': alan,
      'lokasyon': lokasyon,
      'kriter': kriter,
      'tarih': tarih,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('ilanlar', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperIlan.db();
    try {
      await db.delete('ilanlar', where: "id=?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Bilgi silinirken bir hatayla karşılaşıldı: $err");
    }
  }
}
