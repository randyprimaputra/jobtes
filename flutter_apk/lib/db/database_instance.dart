import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../model/membercard_model.dart';

class DatabaseInstance {
  final String _databaseName = 'testjob.db';
  final int _databaseVersion = 1;
  bool isUsernameTaken = false;

  DatabaseInstance() {
    _database = null;
  }

  // MemberCard Table
  final String tableMemberCard = 'TMemberCard';

  final String kodeMember = 'kode_member';
  final String name = 'name';
  final String alamat = 'alamat';
  final String tanggalLahir = 'tanggal_lahir';
  final String jenisKelamin = 'jenis_kelamin';
  final String username = 'username';
  final String password = 'password';

  // Validasi Database
  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Direktori Database
  Future _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Create Table Membercard
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableMemberCard ($kodeMember INTEGER PRIMARY KEY, $name TEXT NULL, $alamat TEXT NULL, $tanggalLahir TEXT NOT NULL,$jenisKelamin TEXT NOT NULL,$username TEXT UNIQUE NOT NULL,$password TEXT NOT NULL)');
  }

  // Fetch All Data Table Membercard
  Future<List<MemberCardModel>?> all() async {
    try {
      final data = await _database!.query(tableMemberCard, orderBy: kodeMember);
      List<MemberCardModel> result =
          data.map((e) => MemberCardModel.fromJson(e)).toList();
      return result;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return null;
    }
  }

// Insert Data Table Membercard
  Future<int> insertDataMemberCard(Map<String, dynamic> row) async {
    final query = await _database!.insert(tableMemberCard, row);
    return query;
  }

// Update Data Table Membercard
  Future<int> updateDataMemberCard(
      int kodeMember, Map<String, dynamic> row) async {
    try {
      final query = await _database!.update(tableMemberCard, row,
          where: '$kodeMember = ?', whereArgs: [kodeMember]);
      return query;
    } catch (error) {
      if (error is DatabaseException && error.isUniqueConstraintError()) {
        isUsernameTaken = true;
        if (kDebugMode) {
          print('Username is already being used');
        }
        return -1;
      } else {
        rethrow;
      }
    }
  }

  Future deleteDataMemberCard(int kodeMember) async {
    await _database!.delete(tableMemberCard,
        where: '$kodeMember = ?', whereArgs: [kodeMember]);
  }
}
