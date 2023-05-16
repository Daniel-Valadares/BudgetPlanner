import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        email TEXT,
        senha TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);

    await database.execute("""
  CREATE TABLE accounts(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    accountNumber TEXT,
    balance REAL,
    userId INTEGER,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
  )
""");

    await database.execute("""
      CREATE TRIGGER delete_accounts
      AFTER DELETE ON users
      FOR EACH ROW
      BEGIN
        DELETE FROM accounts WHERE userId = OLD.id;
      END
    """);

    await database.execute("""
      CREATE TABLE cards(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        accountId INTEGER,
        bankName TEXT,
        isInternational INTEGER,
        FOREIGN KEY (accountId) REFERENCES accounts (id) ON DELETE CASCADE
      )
    """);

    await database.execute("""
      CREATE TRIGGER delete_cards
      AFTER DELETE ON accounts
      FOR EACH ROW
      BEGIN
        DELETE FROM cards WHERE accountId = OLD.id;
      END
    """);

    await database.execute('''
      CREATE TABLE IF NOT EXISTS transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        value REAL,
        description TEXT,
        timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        method TEXT,
        accountId INTEGER,
        cardId INTEGER,
        FOREIGN KEY (accountId) REFERENCES accounts (id),
        FOREIGN KEY (cardId) REFERENCES cards (id)
      )
    ''');

  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbtech11.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<void> createItem(String tableName, Map<String, dynamic> attributes) async {
    final db = await SQLHelper.db();

    // Montar a query de inserção dinamicamente com base nos atributos da tabela
    String query = 'INSERT INTO $tableName (${attributes.keys.join(', ')}) VALUES (${attributes.keys.map((key) => '?').join(', ')})';

    // Executar a query passando os valores dos atributos
    await db.execute(query, attributes.values.toList());
  }



  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems(String tableName) async {
    final db = await SQLHelper.db();
    return db.query(tableName);
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('users', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<void> updateItem(
      String tableName, int id, Map<String, dynamic> attributes) async {
    final db = await SQLHelper.db();
    await db.update(
      tableName,
      attributes,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete
  static Future<void> deleteItem(String tableName, int id) async {
    final db = await SQLHelper.db();
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}