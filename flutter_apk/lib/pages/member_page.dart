// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  final String userName;

  const MemberPage({super.key, required this.userName});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    int? kode_member;
    String? nama;
    String? tanggal_lahir;
    String? alamat;
    String? jenis_kelamin;
    String? username;
    String? password;

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
              subtitle: Text('$kode_member'),
              tileColor: Colors.green.shade300,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Nama"),
              subtitle: Text('$nama'),
              tileColor: Colors.green.shade400,
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text("Tanggal lahir"),
              subtitle: Text('$tanggal_lahir'),
              tileColor: Colors.green.shade300,
            ),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text("Alamat"),
              subtitle: Text('$alamat'),
              tileColor: Colors.green.shade400,
            ),
            ListTile(
              leading: const Icon(Icons.girl_outlined),
              title: const Text("Jenis Kelamin"),
              subtitle: Text('$jenis_kelamin'),
              tileColor: Colors.green.shade300,
            ),
            ListTile(
              leading: const Icon(Icons.key),
              title: const Text("Username"),
              subtitle: Text('${widget.userName}'),
              tileColor: Colors.green.shade400,
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text("Password"),
              subtitle: Text('$password'),
              tileColor: Colors.green.shade300,
              trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
            ),
          ],
        ),
      ),
    );
  }
}
