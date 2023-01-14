import 'package:flutter/material.dart';
import 'package:flutter_apk/components/my_appbar.dart';
import 'package:flutter_apk/db/database_instance.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateMemberPage extends StatefulWidget {
  CreateMemberPage({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: widget.scaffoldKey,
      appBar: const MyAppBar(title: 'Create Member Page'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Expanded(
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
                    await databaseInstance.insertDataMemberCard({
                      'name': nameController.text,
                      'alamat': alamatController.text,
                      'tanggal_lahir': tanggalLahirController.text,
                      'jenis_kelamin': jenisKelaminController.text,
                      'username': usernameController.text,
                      'password': passwordController.text,
                    });
                    if (databaseInstance.isUsernameTaken) {
                      Fluttertoast.showToast(
                          msg: 'Username is already taken',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Create member success',
                        backgroundColor: Colors.green
                      );
                      Navigator.pop(context);
                    }
                  },
                  
                  child: const Text('Simpan'),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
