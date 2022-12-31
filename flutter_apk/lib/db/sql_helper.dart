// ignore_for_file: non_constant_identifier_names

import 'package:flutter_apk/model/membercard_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
static Future<void> createMembercardTable(sql.Database database) async {
    await database.execute("""CREATE TABLE Membercard(
        kode_member INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nama TEXT,
        tanggal_lahir TEXT,
        alamat TEXT,
        jenis_kelamin TEXT,
        username TEXT UNIQUE,
        password TEXT
      )
      """);
  }

  static Future<sql.Database> dbConnection() async {
    return sql.openDatabase(
      'testjob.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createMembercardTable(database);
      },
    );
  }

  //tambah data
  static Future<int> createMembercard(
      {required String nama,
    required String tanggal_lahir,
    required String alamat,
    required String jenis_kelamin,
    required String username,
    required String password}) async {
    final dbConnection = await SQLHelper.dbConnection();

    final data = {
      'nama': nama,
      'tanggal_lahir': tanggal_lahir,
      'alamat': alamat,
      'jenis_kelamin': jenis_kelamin,
      'username': username,
      'password': password
    };
    final kode_member = await dbConnection.insert('Membercard', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return kode_member;
  }



  

  // Read all Membercard
  static Future<List<Map<String, dynamic>>> getDatamembercards() async {
    final dbConnection = await SQLHelper.dbConnection();
    return dbConnection.query('Membercard', orderBy: "kode_member");
  }



  // Read a single Membercard by kode_member
  static Future<List<Map<String, dynamic>>> getUsermembercard(
      var kode_member) async {
    final dbConnection = await SQLHelper.dbConnection();
    return dbConnection.query('Membercard',
        where: "kode_member = ?", whereArgs: [kode_member], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getUserLoginmembercard(
    String username, String password) async {
  final dbConnection = await SQLHelper.dbConnection();
  return dbConnection.query('Membercard',
      where: "username = ? AND password = ?", whereArgs: [username, password], limit: 1);
}

Future<List<MembercardModel>> login(String username, String password) async {
  final membercardList = await SQLHelper.getUserLoginmembercard(username, password);
  return membercardList.map((membercard) => MembercardModel.fromMap(membercard)).toList();
}

  

  // Update a Membercard by kode_member
  static Future<int> updateDatamembercard(
      int kode_member,
      String nama,
      String tanggal_lahir,
      String alamat,
      String jenis_kelamin,
      String username,
      String password) async {
    final dbConnection = await SQLHelper.dbConnection();

    final data = {
      'nama': nama,
      'tanggal_lahir': tanggal_lahir,
      'alamat': alamat,
      'jenis_kelamin': jenis_kelamin,
      'username': username,
      'password': password
    };

    final result = await dbConnection.update('Membercard', data,
        where: "kode_member = ?", whereArgs: [kode_member]);
    return result;
  }

    // Update a Membercard password by kode_member
  static Future<int> updatePasswordmembercard(
      int kode_member,
      String password) async {
    final dbConnection = await SQLHelper.dbConnection();

    final data = {
      'password': password
    };

    final result = await dbConnection.update('Membercard', data,
        where: "kode_member = ?", whereArgs: [kode_member]);
    return result;
  }

  // Delete a Membercard by kode_member
  static Future<void> deleteDatamembercard(int kode_member) async {
    final dbConnection = await SQLHelper.dbConnection();
    try {
      await dbConnection.delete("Membercard",
          where: "kode_member = ?", whereArgs: [kode_member]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
