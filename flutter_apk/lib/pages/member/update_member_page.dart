import 'package:flutter/material.dart';
import '/components/my_appbar.dart';
import '/db/database_instance.dart';
import '/model/membercard_model.dart';

class UpdateMemberPage extends StatefulWidget {
  final MemberCardModel? memberCardModel;
  const UpdateMemberPage({Key? key, this.memberCardModel}) : super(key: key);

  @override
  State<UpdateMemberPage> createState() => _UpdateMemberCard();
}

class _UpdateMemberCard extends State<UpdateMemberPage> {
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
    nameController.text = widget.memberCardModel!.name ?? '';
    alamatController.text = widget.memberCardModel!.alamat ?? '';
    tanggalLahirController.text =
        widget.memberCardModel!.tanggalLahir ?? '';
    jenisKelaminController.text =
        widget.memberCardModel!.jenisKelamin ?? '';
    usernameController.text = widget.memberCardModel!.username ?? '';
    passwordController.text = widget.memberCardModel!.password ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Edit Member Page'),
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
                  await databaseInstance.update(widget.memberCardModel!.kodeMember!,{
                    
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
