import 'package:flutter/material.dart';
import 'package:flutter_apk/sql_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController tanggal_lahirController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController jenis_kelaminController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //ambil data dari database
  List<Map<String, dynamic>> Membercard = [];
  void refreshMembercard() async {
    final data = await SQLHelper.getMembercard();
    setState(() {
      Membercard = data;
    });
  }

  //fungsi tambah
  Future<void> tambahMembercard() async {
    await SQLHelper.tambahMember(
        namaController.text,
        tanggal_lahirController.text,
        alamatController.text,
        jenis_kelaminController.text,
        usernameController.text,
        passwordController.text);
    refreshMembercard();
  }

  //form tambah
  void modalForm(int id) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              height: 800,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: namaController,
                      decoration: const InputDecoration(hintText: 'Nama'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: tanggal_lahirController,
                      decoration:
                          const InputDecoration(hintText: 'Tanggal Lahir'),
                    ),
                     const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: alamatController,
                      decoration: const InputDecoration(hintText: 'Alamat'),
                    ),
                     const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: jenis_kelaminController,
                      decoration:
                          const InputDecoration(hintText: 'Jenis Kelamin'),
                    ),
                     const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(hintText: 'Username'),
                    ),
                     const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                     const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(onPressed: () async{
                      await tambahMembercard();
                    },), child: const Text('tambah'))
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
