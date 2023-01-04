import 'package:flutter/material.dart';

import '../../components/my_appbar.dart';
import '../../db/database_instance.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Use the username and password here as needed
    return Scaffold(
      appBar: const MyAppBar(title: 'Member Page'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 120,
                height: 120,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Nama'),
                enabled: false,
                controller: TextEditingController(text: ' '),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
