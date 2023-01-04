// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../components/my_appbar.dart';
import '../../db/database_instance.dart';
import '../../model/membercard_model.dart';

class MemberPage extends StatefulWidget {
   
  final String? username;
  final String? password;

  const MemberPage({super.key, this.username, this.password});


  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  DatabaseInstance databaseInstance = DatabaseInstance();

  MemberCardModel? loggedInMember;

  @override
  void initState() {
    super.initState();
    databaseInstance
        .getLoggedInMember(password: widget.password.toString(), username: widget.username.toString())
        .then((member) {
      setState(() {
        loggedInMember = member;
        debugPrint('The value of loggedInMember is: $loggedInMember');        
      });
    });
  }
  

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController alamatController = TextEditingController();
    TextEditingController tanggalLahirController = TextEditingController();
    TextEditingController jenisKelaminController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

      nameController.text = loggedInMember!.name.toString();
  alamatController.text = loggedInMember!.alamat.toString();
  tanggalLahirController.text = loggedInMember!.tanggalLahir.toString();
  jenisKelaminController.text = loggedInMember!.jenisKelamin.toString();
  usernameController.text = loggedInMember!.username.toString();
  passwordController.text = loggedInMember!.password.toString();


    // Use the username and password here as needed
    return Scaffold(
      appBar: const MyAppBar(title: 'Member Page'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 120,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Nama'),
                enabled: false,
                controller: nameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Alamat'),
                enabled: false,
                controller: alamatController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                enabled: false,
                controller: tanggalLahirController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                enabled: false,
                controller: jenisKelaminController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Username'),
                enabled: false,
                controller: usernameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Password'),
                controller: passwordController,
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
