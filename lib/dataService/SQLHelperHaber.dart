import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperHaber {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE haberler(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        baslik TEXT,
        icerik TEXT,
        detay TEXT,
        imageUrl1 TEXT,
        imageUrl2 TEXT,
        tarih DATE,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('Haber.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(String baslik, String icerik, String detay,
      String imageUrl1, String imageUrl2) async {
    final db = await SQLHelperHaber.db();
    final data = {
      'baslik': baslik,
      'icerik': icerik,
      'detay': detay,
      'imageUrl1': imageUrl1,
      'imageUrl2': imageUrl2,
      'tarih': DateTime.now().toString(),
    };
    final id = await db.insert('haberler', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperHaber.db();
    return db.query('haberler', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperHaber.db();
    return db.query('haberler', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String baslik, String icerik,
      String detay, String imageUrl1, String imageUrl2) async {
    final db = await SQLHelperHaber.db();
    final data = {
      'baslik': baslik,
      'icerik': icerik,
      'detay': detay,
      'imageUrl1': imageUrl1,
      'imageUrl2': imageUrl2,
      'tarih': DateTime.now().toString(),
    };
    final result =
        await db.update('haberler', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperHaber.db();
    try {
      await db.delete('haberler', where: "id=?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Bilgi silinirken bir hatayla karşılaşıldı: $err");
    }
  }
}
