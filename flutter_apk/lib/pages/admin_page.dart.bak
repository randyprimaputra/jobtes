// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_apk/db/sql_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController tanggal_lahirController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController jenis_kelaminController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//ambil data dari database

  List<Map<String, dynamic>> t_Membercard = [];
  void refreshMembercard() async {
    final data = await SQLHelper.getDatamember();
    setState(() {
      t_Membercard = data;
    });
  }

//tambah record data tabel
  Future<void> tambahMembercard() async {
    await SQLHelper.tambahDatamember(
        namaController.text,
        tanggal_lahirController.text,
        alamatController.text,
        jenis_kelaminController.text,
        usernameController.text,
        passwordController.text);
  }

  //form tambah
  void modalForm() async {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: 800,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //Nama
            TextField(
              controller: namaController,
              decoration: const InputDecoration(hintText: 'Nama'),
            ),
            const SizedBox(
              height: 10,
            ),
            //Tanggal lahir
            TextField(
              controller: tanggal_lahirController,
              decoration: const InputDecoration(hintText: 'Tanggal Lahir'),
            ),
            const SizedBox(
              height: 10,
            ),
            // Alamat
            TextField(
              controller: alamatController,
              decoration: const InputDecoration(hintText: 'Alamat'),
            ),
            const SizedBox(
              height: 10,
            ),
            // Jenis kelamin
            TextField(
              controller: jenis_kelaminController,
              decoration: const InputDecoration(hintText: 'Jenis Kelamin'),
            ),
            const SizedBox(
              height: 10,
            ),
            // Username
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
            const SizedBox(
              height: 10,
            ),
            // Password
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () async{
              await tambahMembercard();
            }, child: const Text('Tambah'),)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(t_Membercard);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        backgroundColor: Colors.green[800],
      ),
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.lock_person,
                size: 100,
                color: Colors.white,
              ),
 
              // Hello Admin !
              Text(
                'Hello Admin !',
                style: GoogleFonts.bebasNeue(
                  fontSize: 36,
                ),
              ),

              // sign out button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.green[700],
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Center(
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          modalForm();
        },
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
