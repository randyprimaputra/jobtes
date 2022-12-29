// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';

import '../db/sql_helper.dart';

class MemberPage extends StatefulWidget {
  final String username;

  const MemberPage({super.key, required this.username});

  @override
  State<MemberPage> createState() => _MemberPageState();
}


class _MemberPageState extends State<MemberPage> {

  List<Map<String, dynamic>> _membercard = [];

   bool _isLoading = true;
  
  // This function is used to fetch all data from the database
  void _refreshDatamembercard() async {
    final data = await SQLHelper.getDatamembercard();
    if (mounted) {
      setState(() {
        _membercard = data;
        _isLoading = false;
      });
    }
  }
    @override
  void initState() {
    super.initState();
    _refreshDatamembercard(); // Loading the data when the page starts
  }
  

  @override
  void initState() {
    super.initState();
    _refreshDatamembercard(); // Loading the data when the page starts
  }

      // Update an existing password Membercard by kode_member
  Future<void> _updateDataPasswordmembercard(int kode_member) async {
    await SQLHelper.updatePasswordmembercard(
        kode_member,
        _passwordController.text);
        _refreshDatamembercard();
  }

      Future<void> fetchMemberData(String name, tanggal_lahir, alamat, jenis_kelamin, username, password) async {
    final db = await SQLHelper.db();
    final memberData = await db.query('Membercard',
      where: "username = ?", whereArgs: [widget.username], limit: 1);


    setState(() {
      kode_member = memberData[0]['kode_member'];
      name = memberData[0]['nama'];
      tanggal_lahir = memberData[0]['tanggal_lahir'];
      alamat = memberData[0]['alamat'];
      jenis_kelamin = memberData[0]['jenis_kelamin'];
      username = memberData[0]['username'];
      password = memberData[0]['password'];
    });
  }


    @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Member Page'),
        backgroundColor: Colors.green.shade700,
      ),
      // Add your member page content here

      body: Container(
        child: ListView(
          children: [
            
            ListTile(
              leading: const Icon(Icons.info_rounded),
              title: const Text("Kode Member"),
              subtitle: const Text('kode_member'),
              tileColor: Colors.green.shade300,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Nama"),
              subtitle: const Text('name'),
              tileColor: Colors.green.shade400,
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text("Tanggal lahir"),
              subtitle: const Text('tanggal_lahir'),
              tileColor: Colors.green.shade300,
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text("Alamat"),
              subtitle: const Text('alamat'),
              tileColor: Colors.green.shade400,
            ),
            ListTile(
              leading: const Icon(Icons.girl_outlined),
              title: const Text("Jenis Kelamin"),
              subtitle: const Text('jenis_kelamin'),
              tileColor: Colors.green.shade300,
            ),
            ListTile(
              leading: const Icon(Icons.key),
              title: const Text("Username"),
              subtitle: Text('${widget.username}'),
              tileColor: Colors.green.shade400,
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text("Password"),
              subtitle: const Text('password'),
              tileColor: Colors.green.shade300,
              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
            ),
          ],
        ),
      ),
    );
  } 
}
}


