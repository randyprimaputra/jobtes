import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(""" 
    CREATE TABLE Membercard(
      Kode_member INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      Nama TEXT,
      Tanggal_lahir TEXT,
      Alamat TEXT,
      Jenis_Kelamin TEXT,
      Username TEXT,
      Password TEXT,
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('Membercard', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  //add database
  static Future<int> tambahMember(
      String Nama,
      String Tanggal_lahir,
      String Alamat,
      String Jenis_Kelamin,
      String Username,
      String Password) async {
    final db = await SQLHelper.db();
    final data = {
      'Nama': Nama,
      'Tanggal Lahir': Tanggal_lahir,
      'Alamat': Alamat,
      'Jenis Kelamin': Jenis_Kelamin,
      'Username': Username,
      'Password': Password
    };
    return await db.insert('Membercard', data);
  }

  //ambil data
  static Future<List<Map<String, dynamic>>> getMembercard() async {
    final db = await SQLHelper.db();
    return db.query('Membercard');
  }
}
