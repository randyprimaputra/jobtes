// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';

import '../db/sql_helper.dart';

class MemberPage extends StatefulWidget {

  final String userName;
  final String passWord;

  const MemberPage({super.key, required this.userName, required this.passWord});

  @override
  State<MemberPage> createState() => _MemberPageState();
}


class _MemberPageState extends State<MemberPage> {

   bool _isLoading = true;
   var kode_member;
   final _passwordController = TextEditingController();

  // This function is used to fetch all data from the database

  @override
  void initState() {
    super.initState();
    _refreshUserLoginmembercard(); // Loading the data when the page starts
  }

  // This function is used to fetch data from the database
  void _refreshUserLoginmembercard() async {
  var userName;
  var passWord;
    final data = await SQLHelper.getUserLoginmembercard(widget.userName,widget.passWord);
    if (mounted) {
      setState(() {
        var membercard = data;
        _isLoading = false;
      });
    }
  }
  
      // Update an existing password Membercard by kode_member
  Future<void> _updateDataPasswordmembercard(int kode_member) async {
    await SQLHelper.updatePasswordmembercard(
        kode_member,
        _passwordController.text);
        _refreshUserLoginmembercard();
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

      body: ListView(
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
            subtitle: Text('${widget.userName}'),
            tileColor: Colors.green.shade400,
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text("Password"),
            subtitle: TextField(
    controller: _passwordController,
    obscureText: true,
  ),
            tileColor: Colors.green.shade300,
            trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
          ),
        ],
      ),
    );
  } 
}
}


