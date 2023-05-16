import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        email TEXT,
        senha TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a user
// title, description: name and description of your activity
// created_at: the time that the user was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbtech.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new user (journal)
  static Future<int> createUser(String nome, String? email, String? senha) async {
    final db = await SQLHelper.db();

    final data = {'nome': nome, 'email': email, 'senha': senha};
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<Map<String, String>> getItemByEmail(String email) async {
    final db = await SQLHelper.db();
    final result = await db.query('items', where: "email = ?", whereArgs: [email], limit: 1);

    if (result.isNotEmpty) {
      final user = <String, String>{};
      final row = result.first;

      user['id'] = row['id'].toString();
      user['nome'] = row['nome'].toString();
      user['email'] = row['email'].toString();
      user['senha'] = row['senha'].toString();

      print('coisa' + user.toString());
      return user;
    }

    return {};
  }

  static Future<bool> getItemByEmailBool(String email, String senha) async {
    bool existe = false;
    final db = await SQLHelper.db();
    final result = await db.query('items', where: "email = ? and senha= ?", whereArgs: [email, senha], limit: 1);

    if (result.isNotEmpty) {
      final user = <String, String>{};
      final row = result.first;

      user['id'] = row['id'].toString();
      user['nome'] = row['nome'].toString();
      user['email'] = row['email'].toString();
      user['senha'] = row['senha'].toString();

      print('coisa' + user.toString());
      existe = true;
      return existe;
    }

    return existe;
  }


  // Update an item by id
  static Future<int> updateItem(
      int id, String nome, String? email, String? senha) async {
    final db = await SQLHelper.db();

    final data = {
      'nome': nome,
      'email': email,
      'senha': senha,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}