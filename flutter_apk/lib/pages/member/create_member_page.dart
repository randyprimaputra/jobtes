import 'package:flutter/material.dart';
import 'package:flutter_apk/components/my_appbar.dart';
import 'package:flutter_apk/db/database_instance.dart';

class CreateMemberPage extends StatefulWidget {
  const CreateMemberPage({super.key});

  @override
  State<CreateMemberPage> createState() => _CreateMemberPageState();
}

class _CreateMemberPageState extends State<CreateMemberPage> {
  //panggi database
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Create Member Page'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nama'),
            TextField(controller: nameController),
            const SizedBox(height: 15),
            const Text('Alamat'),
            TextField(controller: alamatController),
            const Text('Tanggal Lahir'),
            TextField(controller: tanggalLahirController),
            const SizedBox(height: 15),
            const Text('Jenis Kelamin'),
            TextField(controller: jenisKelaminController),
            const Text('Username'),
            TextField(controller: usernameController),
            const SizedBox(height: 15),
            const Text('Password'),
            TextField(controller: passwordController),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async {
                  await databaseInstance.insert({
                    'name': nameController.text,
                    'alamat': alamatController.text,
                    'tanggal_lahir': tanggalLahirController.text,
                    'jenis_kelamin': jenisKelaminController.text,
                    'username': usernameController.text,
                    'password': passwordController.text,
                  });
                  Navigator.pop(context);
                  //  setState(() {});
                },
                child: const Text('Simpan'))
          ],
        ),
      ),
    );
  }
}
