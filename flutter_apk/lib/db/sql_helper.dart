import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  // fungsi membuat database
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
CREATE TABLE t_Membercard(
  kode_member INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  nama TEXT,
  tanggal_lahir TEXT,
  alamat TEXT,
  jenis_kelamin TEXT,
  username TEXT,
  password TEXT,
)
''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('testjob.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  //tambah data
  // ignore: non_constant_identifier_names
  static Future<int> tambahDatamember(String nama, String tanggal_lahir, String alamat, String jenis_kelamin, String username, String password ) async {
    final db = await SQLHelper.db();
    final data = {'nama': nama,'tanggal_lahir': tanggal_lahir,'alamat': alamat,'jenis_kelamin': jenis_kelamin,'username': username, 'password': password};
    return await db.insert('t_Membercard', data);
  }

  //ambil data
  static Future<List<Map<String, dynamic>>> getDatamember() async {
    final db = await SQLHelper.db();
    return db.query('t_Membercard');
  }
}
