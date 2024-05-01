import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperBasvuru {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE basvurular(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ilanid INTEGER,
        personid INTEGER,
        companyid INTEGER,
        companyName TEXT,
        sonuc TEXT,
        tarih DATE,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('Basvurular.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(int ilanid, int personid, int companyid,
      String companyName, String sonuc) async {
    final db = await SQLHelperBasvuru.db();
    final data = {
      'ilanid': ilanid,
      'personid': personid,
      'companyid': companyid,
      'companyName': companyName,
      'sonuc': sonuc,
      'tarih': DateTime.now().toString(),
    };
    final id = await db.insert('basvurular', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperBasvuru.db();
    return db.query('basvurular', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperBasvuru.db();
    return db.query('basvurular', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, int ilanid, int personid, int companyid,
      String companyName, String sonuc, String tarih) async {
    final db = await SQLHelperBasvuru.db();
    final data = {
      'ilanid': ilanid,
      'personid': personid,
      'companyid': companyid,
      'companyName': companyName,
      'sonuc': sonuc,
      'tarih': tarih,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('basvurular', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateState(int id, String sonuc) async {
    final db = await SQLHelperBasvuru.db();
    final data = {
      'sonuc': sonuc,
    };
    final result =
        await db.update('basvurular', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperBasvuru.db();
    try {
      await db.delete('basvurular', where: "id=?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Bilgi silinirken bir hatayla karşılaşıldı: $err");
    }
  }
}
