import 'package:banca_app/backend/models/user.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  Database? userDatabase;
  User? currentUser;

  final storage = const FlutterSecureStorage();

  Future<User?> login({
    required String email,
    required String password,
    required bool saveUser,
  }) async {
    final User? user = await getUserByEmailAndPassword(email, password);

    if (user != null && saveUser) {
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
    }

    currentUser = user;
    notifyListeners();

    return user;
  }

  Future<User?> register({
    required String name,
    required String identification,
    required String email,
    required String password,
  }) async {
    final User user = User(
      name: name,
      identification: identification,
      email: email,
      password: password,
    );

    await saveUser(user);

    return user;
  }

  Future<void> logout() async {
    await storage.deleteAll();
    currentUser = null;
    notifyListeners();
  }

  Future<Database> createUserDatabase() async {
    userDatabase = await openDatabase(
      join(await getDatabasesPath(), 'users_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, email TEXT, identification TEXT, password TEXT)",
        );
      },
      version: 1,
    );
    notifyListeners();
    return userDatabase as Database;
  }

  Future<void> saveUser(User user) {
    final Database db = userDatabase!;

    return db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser(String email) async {
    final List<Map<String, Object?>> queryResult = await userDatabase!
        .query('user', where: 'email = ?', whereArgs: [email]);
    if (queryResult.isEmpty) {
      return null;
    }
    return User.fromMap(queryResult.first);
  }

  Future<User?> getUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    final List<Map<String, Object?>> queryResult =
        await (userDatabase as Database).query('user',
            where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (queryResult.isEmpty) {
      return null;
    }
    return User.fromMap(queryResult.first);
  }
}
