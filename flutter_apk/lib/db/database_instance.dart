import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseInstance {
  final String _databaseName = 'testjob.db';
  final int _databaseVersion = 1;

  // Product Table
  final String kodeMember = 'kode_member';
  final String name = 'name';
  final String password = 'password';
  final String jenisKelamin = 'jenis_kelamin';
  final String username = 'username';
  final String pass = 'password';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return openDatabase(path, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {

  }
}
