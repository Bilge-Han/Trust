import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperPerson {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE persons(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        userName TEXT,
        password TEXT,
        yetki TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Person.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
      String userName, String password, String yetki) async {
    final db = await SQLHelperPerson.db();

    final data = {
      'userName': userName,
      'password': password,
      'yetki': yetki,
    };
    final id = await db.insert('persons', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all persons (persons)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelperPerson.db();
    return db.query('persons', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelperPerson.db();
    return db.query('persons', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String userName, String password, String yetki) async {
    final db = await SQLHelperPerson.db();

    final data = {
      'userName': userName,
      'password': password,
      'yetki': yetki,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('persons', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelperPerson.db();
    try {
      await db.delete("persons", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
