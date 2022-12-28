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
         
        },
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.group_add),
      ),
    );
  }
}
