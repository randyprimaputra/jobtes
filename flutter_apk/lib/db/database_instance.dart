import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../model/membercard_model.dart';

class DatabaseInstance {
  final String _databaseName = 'testjob.db';
  final int _databaseVersion = 1;

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

  // Membuat Table Membercard
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableMemberCard ($kodeMember INTEGER PRIMARY KEY, $name TEXT NULL, $alamat TEXT NULL, $tanggalLahir TEXT NOT NULL,$jenisKelamin TEXT NOT NULL,$username TEXT UNIQUE NOT NULL,$password TEXT NOT NULL)');
  }

  // Fetch all data MemberCard
  Future<List<MemberCardModel>> all() async {
    final data = await _database!.query(tableMemberCard);
    List<MemberCardModel> result =
        data.map((e) => MemberCardModel.fromJson(e)).toList();
    if (kDebugMode) {
      print(result);
    }
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(tableMemberCard, row);
    return query;
  }

    Future<int> update(int kodeMember, Map<String, dynamic> row) async {
    final query = await _database!.update(tableMemberCard, row, where: '$kodeMember = ?', whereArgs: [kodeMember]);
    return query;
  }
}
