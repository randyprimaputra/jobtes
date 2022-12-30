// ignore_for_file: non_constant_identifier_names

import 'package:flutter_apk/model/membercard_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../pages/member_page.dart';

class SQLHelper {
static Future<void> createTables(sql.Database database) async {
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

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'testjob.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  //tambah data
  static Future<int> createMembercard(
      String nama,
      String tanggal_lahir,
      String alamat,
      String jenis_kelamin,
      String username,
      String password) async {
    final db = await SQLHelper.db();

    final data = {
      'nama': nama,
      'tanggal_lahir': tanggal_lahir,
      'alamat': alamat,
      'jenis_kelamin': jenis_kelamin,
      'username': username,
      'password': password
    };
    final kode_member = await db.insert('Membercard', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return kode_member;
  }



  

  // Read all Membercard
  static Future<List<Map<String, dynamic>>> getDatamembercards() async {
    final db = await SQLHelper.db();
    return db.query('Membercard', orderBy: "kode_member");
  }

List<Map<String, dynamic>> result = await getUsermembercard(username, password);
if (result.isNotEmpty) {
  Map<String, dynamic> row = result[0];
  MembercardModel membercard = MembercardModel(
    kodeMemberModel: row['kode_member'],
    namaModel: row['nama'],
    tanggalLahirModel: row['tanggal_lahir'],
    alamatModel: row['alamat'],
    jenisKelaminModel: row['jenis_kelamin'],
    usernameModel: row['username'],
    passwordModel: row['password'],
  );
  ChangeNotifierProvider(
    create: (_) => membercard,
    child: MemberPage(),
  );
}



  // Read a single Membercard by kode_member
  static Future<List<Map<String, dynamic>>> getUsermembercard(
      var kode_member) async {
    final db = await SQLHelper.db();
    return db.query('Membercard',
        where: "kode_member = ?", whereArgs: [kode_member], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getUserLoginmembercard(
    String username, String password) async {
  final db = await SQLHelper.db();
  return db.query('Membercard',
      where: "username = ? AND password = ?", whereArgs: [username, password], limit: 1);
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
    final db = await SQLHelper.db();

    final data = {
      'nama': nama,
      'tanggal_lahir': tanggal_lahir,
      'alamat': alamat,
      'jenis_kelamin': jenis_kelamin,
      'username': username,
      'password': password
    };

    final result = await db.update('Membercard', data,
        where: "kode_member = ?", whereArgs: [kode_member]);
    return result;
  }

    // Update a Membercard password by kode_member
  static Future<int> updatePasswordmembercard(
      int kode_member,
      String password) async {
    final db = await SQLHelper.db();

    final data = {
      'password': password
    };

    final result = await db.update('Membercard', data,
        where: "kode_member = ?", whereArgs: [kode_member]);
    return result;
  }

  // Delete a Membercard by kode_member
  static Future<void> deleteDatamembercard(int kode_member) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("Membercard",
          where: "kode_member = ?", whereArgs: [kode_member]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
