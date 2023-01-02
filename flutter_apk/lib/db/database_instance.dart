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
        'CREATE TABLE $tableMemberCard ($kodeMember INTEGER PRIMARY KEY, $name TEXT , $alamat TEXT , $tanggalLahir TEXT NULL,$jenisKelamin TEXT ,$username TEXT ,$password TEXT )');
  }

  // Fetch All Data Table Membercard
  Future<List<MemberCardModel>?> dataMembercard() async {
    try {
      final data = await _database!.query(tableMemberCard , orderBy: kodeMember);
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
    try{
    final query = await _database!.insert(tableMemberCard, row,);
    return query;
  }catch (error) {
    if (error is DatabaseException && error.isUniqueConstraintError()) {
      isUsernameTaken = true;
      if (kDebugMode) {
        print('Username is already being used');
      }
      return -1;
    } else {
      rethrow;
    }
  }}

// Update Data Table Membercard
  // Future<int> updateDataMemberCard(
  //     int kodeMember, Map<String, dynamic> row) async {
  //   try {
  //     final query = await _database!.update(tableMemberCard, row,
  //         where: 'kode_member = ?', whereArgs: [kodeMember]);
  //     return query;
  //   } catch (error) {
  //     if (error is DatabaseException && error.isUniqueConstraintError()) {
  //       isUsernameTaken = true;
  //       if (kDebugMode) {
  //         print('Username is already being used');
  //       }
  //       return -1;
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

// Future<int> updateDataMemberCard(
//     int kodeMember, Map<String, dynamic> row) async {
//   try {
//     // Check if the new username is already being used by another member
//     final existingMember = await _database!.query(tableMemberCard,
//         where: 'username = ?', whereArgs: [row[username] as String]);
//     if (existingMember.isNotEmpty) {
//       // If the new username is already being used, return -1 to indicate that the update failed
//       return -1;
//     }
//     // If the new username is not being used, proceed with the update
//     final query = await _database!.update(tableMemberCard, row,
//         where: 'kode_member = ?', whereArgs: [kodeMember]);
//     return query;
//   } catch (error) {
//     rethrow;
//   }
// }

Future<int> updateDataMemberCard(
      int kodeMember, Map<String, dynamic> row) async {
    final query = await _database!.update(tableMemberCard, row,
        where: 'kode_member = ?', whereArgs: [kodeMember], conflictAlgorithm: ConflictAlgorithm.replace);
    return query;
  }




  Future deleteDataMemberCard(int kodeMember) async {
    await _database!.delete(tableMemberCard,
        where: 'kode_member = ?', whereArgs: ['$kodeMember']);
  }
}
