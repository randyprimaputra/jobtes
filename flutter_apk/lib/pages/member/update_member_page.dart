// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import '/components/my_appbar.dart';
import '/db/database_instance.dart';
import '/model/membercard_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateMemberPage extends StatefulWidget {
  final MemberCardModel? memberCardModel;
  UpdateMemberPage({Key? key, this.memberCardModel}) : super(key: key);

  //panggil catch eror username taken
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    nameController.text = widget.memberCardModel?.name ?? '';
    alamatController.text = widget.memberCardModel?.alamat ?? '';
    tanggalLahirController.text = widget.memberCardModel?.tanggalLahir ?? '';
    jenisKelaminController.text = widget.memberCardModel?.jenisKelamin ?? '';
    usernameController.text = widget.memberCardModel?.username ?? '';
    passwordController.text = widget.memberCardModel?.password ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: const MyAppBar(title: 'Edit Member Page'),
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
                TextField(
                  controller: usernameController,
                  enabled: true,
                ),
                const SizedBox(height: 15),
                const Text('Password'),
                TextField(controller: passwordController),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    // Update the data in the table
                    await databaseInstance.updateDataMemberCard(
                      widget.memberCardModel!.kodeMember!,
                      {
                        'name': nameController.text,
                        'alamat': alamatController.text,
                        'tanggal_lahir': tanggalLahirController.text,
                        'jenis_kelamin': jenisKelaminController.text,
                        'username': usernameController.text,
                        'password': passwordController.text,
                      },
                    );

                    // Show a toast message to confirm the update
                    Fluttertoast.showToast(
                      msg: 'Update member success',
                    );

                    // Pop the current page
                    Navigator.pop(context);
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
