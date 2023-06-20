import 'package:budget_planner/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:budget_planner/models/global.dart';

class UserDAO {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        email TEXT,
        senha TEXT,
        totalSpent REAL,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
    await database.execute("""
  CREATE TABLE accounts(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    bankName TEXT,
    balance REAL,
    userId INTEGER,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE
  )
""");
    await database.execute("""
      CREATE TABLE cards(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        accountId INTEGER,
        userId INTEGER,
        bankName TEXT,
        isInternational INTEGER,
        FOREIGN KEY (accountId) REFERENCES accounts (id) ON DELETE CASCADE,
        FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE
      )
    """);

    await database.execute('''
      CREATE TABLE IF NOT EXISTS transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        value REAL,
        description TEXT,
        bankName TEXT,
        timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        method INTEGER,
        accountId INTEGER,
        userId INTEGER,
        FOREIGN KEY (accountId) REFERENCES accounts (id),
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');

    await database.execute("""
      CREATE TRIGGER delete_cards
      AFTER DELETE ON accounts
      FOR EACH ROW
      BEGIN
        DELETE FROM cards WHERE accountId = OLD.id;
      END
    """);
    await database.execute("""
      CREATE TRIGGER delete_transactions
      AFTER DELETE ON accounts
      FOR EACH ROW
      BEGIN
        DELETE FROM cards WHERE accountId = OLD.id;
      END
    """);

    await database.execute("""
      CREATE TRIGGER delete_accounts
      AFTER DELETE ON users
      FOR EACH ROW
      BEGIN
        DELETE FROM accounts WHERE userId = OLD.id;
      END
    """);
  }
// id: the id of a user
// title, description: name and description of your activity
// created_at: the time that the user was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbapresentacao1.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new user (journal)
  static Future<int> createUser(String nome, String? email, String? senha) async {
    final db = await UserDAO.db();
    final data = {'nome': nome, 'email': email, 'senha': _textToMd5(senha!), 'totalSpent': 0};
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createAccountItem(int userId, String bankName, double balance) async {
    final db = await UserDAO.db();

    final data = {'userId': userId, 'bankName': bankName, 'balance': balance};
    final id = await db.insert('accounts', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print(data);
    return id;
  }
  static Future<int> createCardItem(int userId, int bankId, int isInternational) async {
    final db = await UserDAO.db();
    final bank = await db.query('accounts', where: 'id=?', whereArgs: [bankId]);
    final row = bank.first;
    final data = {'userId': userId, 'accountId': bankId, 'bankName': row['bankName'].toString(), 'isInternational': isInternational};
    final id = await db.insert('cards', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print(data);
    return id;
  }

  static Future<int> createTransactionItem(int userId, double value,String description, int bankId, int method) async {
    await TransactionOnAccount(bankId, value);
    final db = await UserDAO.db();
    final bank = await db.query('accounts', where: 'id=?', whereArgs: [bankId]);
    final row = bank.first;
    final data = {'value': value,'description': description, 'userId': userId, 'accountId': bankId, 'bankName': row['bankName'].toString(), 'method': method};
    final id = await db.insert('transactions', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print(data);
    return id;
  }

  // Read all users (journals)
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await UserDAO.db();
    return db.query('users', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getAccountItems(int userId) async {
    final db = await UserDAO.db();
    return db.query('accounts', orderBy: "id", where: "userId = ?", whereArgs: [userId]);
  }

  static Future<List<Map<String, dynamic>>> getCardItems(int userId) async {
    final db = await UserDAO.db();
    return db.query('cards', orderBy: "id", where: "userId = ?", whereArgs: [userId]);
  }

  static Future<List<Map<String, dynamic>>> getTransactionItems(int userId) async {
    final db = await UserDAO.db();
    return db.query('transactions', orderBy: "id", where: "userId = ?", whereArgs: [userId]);
  }

  // Read a single user by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getUser(int id) async {
    final db = await UserDAO.db();
    return db.query('users', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<Map<String, String>> getUserByEmail(String email) async {
    final db = await UserDAO.db();
    final result = await db.query('users', where: "email = ?", whereArgs: [email], limit: 1);

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

  static Future<String> getUserByEmailGiveName(String email) async{
    final db = await UserDAO.db();
    final result = await db.query('users', where: "email = ?", whereArgs: [email], limit: 1);

    if (result.isNotEmpty) {
      final user = <String, String>{};
      final row = result.first;

      user['id'] = row['id'].toString();
      user['nome'] = row['nome'].toString();
      user['email'] = row['email'].toString();
      user['senha'] = row['senha'].toString();

      return ( user['nome'].toString());
    }

    return ('anonimo');
  }

  static Future<String> getUserByEmailGiveID(String email) async{
    final db = await UserDAO.db();
    final result = await db.query('users', where: "email = ?", whereArgs: [email], limit: 1);

    if (result.isNotEmpty) {
      final user = <String, String>{};
      final row = result.first;

      user['id'] = row['id'].toString();
      user['nome'] = row['nome'].toString();
      user['email'] = row['email'].toString();
      user['senha'] = row['senha'].toString();

      return ( user['id'].toString());
    }

    return ("-1");
  }

  static Future<double> getUserByEmailGiveTotal(String email) async{
    final db = await UserDAO.db();
    final result = await db.query('users', where: "email = ?", whereArgs: [email], limit: 1);

    if (result.isNotEmpty) {
      final user = <String, String>{};
      final row = result.first;

      user['id'] = row['id'].toString();
      user['nome'] = row['nome'].toString();
      user['email'] = row['email'].toString();
      user['senha'] = row['senha'].toString();
      user['totalSpent'] = row['totalSpent'].toString();

      return ( double.parse(user['totalSpent'].toString()));
    }

    return (0);
  }

  static Future<bool> getUserByEmailBool(String email, String senha) async {
    bool existe = false;
    final db = await UserDAO.db();
    final result = await db.query('users', where: "email = ? and senha= ?", whereArgs: [email, _textToMd5(senha!)], limit: 1);

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

  // Update an users by id
  static Future<int> updateUser(int id, String? nome, String? email, String? senha) async {
    final db = await UserDAO.db();

    final data = {
      'nome': nome,
      'email': email,
      'senha': _textToMd5(senha!),
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateAccountItem(
      int id, String nome, double saldo) async {
    final db = await UserDAO.db();

    final data = {
      'bankName': nome,
      'balance': saldo,
    };

    final result =
    await db.update('accounts', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateCardItem(
      int id, int bankId, int isInternational) async {
    final db = await UserDAO.db();
    final bank = await db.query('accounts', where: 'id=?', whereArgs: [bankId]);
    final row = bank.first;
    final data = {
      'bankName': row['bankName'].toString(),
      'isInternational': isInternational,
    };

    final result =
    await db.update('cards', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteUser(int id) async {
    final db = await UserDAO.db();
    try {
      await db.delete("users", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an User: $err");
    }
  }

  static Future<void> deleteAccountItem(int id) async {
    final db = await UserDAO.db();
    try {
      await db.delete("accounts", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteCardItem(int id) async {
    final db = await UserDAO.db();
    try {
      await db.delete("cards", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteTransactionItem(int id) async {
    final db = await UserDAO.db();
    try {
      await db.delete("transactions", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Metodos auxiliares

  static String _textToMd5 (String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  static Future<int> TransactionOnAccount(
      int id, double value) async {
    final db = await UserDAO.db();
    final original = await db.query('accounts', where: 'id=?', whereArgs: [id]);
    final row = original.first;
    final usertotal = await db.query('users', where: 'id=?', whereArgs: [id]);
    final userrow = usertotal.first;
    double aux = double.parse(row['balance'].toString());
    double aux2 = double.parse(userrow['totalSpent'].toString());
    double newTotal = aux2+value;
    total = newTotal;
    restante = limite - total;
    double newBalance = aux-value;
    int userId = int.parse(userrow['id'].toString());
    final data = {
      'bankName': row['bankName'].toString(),
      'balance': newBalance,
    };
    final userdata = {
      'totalSpent': newTotal,
    };

    final result =
    await db.update('accounts', data, where: "id = ?", whereArgs: [id]);
    await db.update('users', userdata, where: "id = ?", whereArgs: [userId]);
    return result;
  }
}