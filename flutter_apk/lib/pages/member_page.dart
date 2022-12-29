// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, unused_local_variable, unused_element, avoid_unnecessary_containers, unused_field

//! masih error untuk mengambil data member sesuai login selain username
//! masih error untuk mengannti password member sesuai login

import 'package:flutter/material.dart';

import '../db/sql_helper.dart';

class MemberPage extends StatefulWidget {
  final String username;

  const MemberPage({super.key, required this.username});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  // List<Map<String, dynamic>> _membercards = [];

  // bool _isLoading = true;

  // This function is used to fetch all data from the database
  // void _refreshDatamembercard() async {
  //   final data = await SQLHelper.getDatamembercard();
  //   if (mounted) {
  //     setState(() {
  //       _membercards = data;
  //       _isLoading = false;
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _refreshDatamembercard(); // Loading the data when the page starts
  // }

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggal_lahirController =
      TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _jenis_kelaminController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // var kode_member;

  // Future<void> fetchMemberData(String name, tanggal_lahir, alamat,
  //     jenis_kelamin, username, password) async {
  //   final db = await SQLHelper.db();
  //   final memberData = await db.query('Membercard',
  //       where: "kode_member = ?", whereArgs: [kode_member], limit: 1);

  //   setState(() {
  //     tanggal_lahir = memberData[0]['tanggal_lahir'];
  //     alamat = memberData[0]['alamat'];
  //     jenis_kelamin = memberData[0]['jenis_kelamin'];
  //     username = memberData[0]['username'];
  //     password = memberData[0]['password'];
  //   });
  // }

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when want to update a Membercard
  // void _showForm(int? kode_member) async {
  //   if (kode_member != null) {
  //     // kode_member == null -> create new item
  //     // kode_member != null -> update an existing item
  //     final existingMembercard = _membercards
  //         .firstWhere((element) => element['kode_member'] == kode_member);
  //     _namaController.text = existingMembercard['nama'];
  //     _tanggal_lahirController.text = existingMembercard['tanggal_lahir'];
  //     _alamatController.text = existingMembercard['alamat'];
  //     _jenis_kelaminController.text = existingMembercard['jenis_kelamin'];
  //     _usernameController.text = existingMembercard['username'];
  //     _passwordController.text = existingMembercard['password'];
  //   }

  // // Update an existing password Membercard by kode_member
  // Future<void> _updateDataPasswordmembercard(int kode_member) async {
  //   await SQLHelper.updatePasswordmembercard(
  //       kode_member, _passwordController.text);
  //   _refreshDatamembercard();
  // }

  // showModalBottomSheet(
  //   context: context,
  //   elevation: 1,
  //   isScrollControlled: true,
  //   builder: (_) => Container(
  //     padding: EdgeInsets.only(
  //       top: 60,
  //       left: 15,
  //       right: 15,
  //       // this will prevent the soft keyboard from covering the text fields
  //       bottom: MediaQuery.of(context).viewInsets.bottom != 0
  //           ? MediaQuery.of(context).viewInsets.bottom
  //           : 120,
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //         TextField(
  //           controller: _passwordController,
  //           decoration: const InputDecoration(hintText: 'Password'),
  //         ),
  //         TextField(
  //           controller: _passwordController,
  //           decoration: const InputDecoration(hintText: 'Password'),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         ElevatedButton(
  //           onPressed: () async {
  //             // Save new Membercard
  //             if (kode_member == null) {
  //               await _updateDataPasswordmembercard(kode_member);
  //             }

  //             if (kode_member != null) {
  //               await _updateDataPasswordmembercard(kode_member);
  //             }
  //             // Close the bottom sheet
  //             Navigator.of(context).pop();
  //           },
  //           child: Text(kode_member == null ? 'Create New' : 'Update'),
  //         )
  //       ],
  //     ),
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
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
                trailing: IconButton(
                    onPressed: (
                        /* _showForm(_membercards[]['kode_member']*/) {},
                    icon: const Icon(Icons.edit))),
          ],
        ),
      ),
    );
  }
}
