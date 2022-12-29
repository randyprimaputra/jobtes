// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_apk/db/sql_helper.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
//All _membercards
  List<Map<String, dynamic>> _membercards = [];

  bool _isLoading = true;

// This function is used to fetch all data from the database
  void _refreshDatamembercards() async {
    final data = await SQLHelper.getDatamembercards();
    if (mounted) {
      setState(() {
        _membercards = data;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshDatamembercards(); // Loading the data when the page starts
  }

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggal_lahirController =
      TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _jenis_kelaminController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _jenisKelamin;
  // This function will be triggered when the floating button is pressed
  // It will also be triggered when want to update a Membercard
  void _showForm(int? kode_member) async {
    if (kode_member != null) {
      // kode_member == null -> create new item
      // kode_member != null -> update an existing item
      final existingMembercard = _membercards
          .firstWhere((element) => element['kode_member'] == kode_member);
      _namaController.text = existingMembercard['nama'];
      _tanggal_lahirController.text = existingMembercard['tanggal_lahir'];
      _alamatController.text = existingMembercard['alamat'];
      _jenis_kelaminController.text = existingMembercard['jenis_kelamin'];
      _usernameController.text = existingMembercard['username'];
      _passwordController.text = existingMembercard['password'];
      _jenisKelamin = existingMembercard['jenis_kelamin'];
    }

    showModalBottomSheet(
      context: context,
      elevation: 1,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 15,
          right: 15,
          // this will prevent the soft keyboard from covering the text fields
          bottom: MediaQuery.of(context).viewInsets.bottom != 0
              ? MediaQuery.of(context).viewInsets.bottom
              : 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                hintText: 'Nama',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _tanggal_lahirController,
              decoration: const InputDecoration(hintText: 'Tanggal Lahir'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _alamatController,
              decoration: const InputDecoration(hintText: 'Alamat'),
            ),
            const SizedBox(
              height: 10,
            ),
            /*
            TextField(
              controller: _jenis_kelaminController,
              decoration: const InputDecoration(hintText: 'Jenis Kelamin'),
            ), */

            DropdownButtonFormField(
              value: _jenisKelamin,
              decoration: const InputDecoration(hintText: 'Jenis Kelamin'),
              items: ['Laki-laki', 'Perempuan']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _jenisKelamin = value as String?;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                // Save new Membercard
                if (kode_member == null) {
                  await _addDatamembercard();
                }

                if (kode_member != null) {
                  await _updateDatamembercard(kode_member);
                }

                // Clear the text fields
                _namaController.text = '';
                _tanggal_lahirController.text = '';
                _alamatController.text = '';
                _jenisKelamin = '';
                _usernameController.text = '';
                _passwordController.text = '';

                // Close the bottom sheet
                Navigator.of(context).pop();
              },
              child: Text(kode_member == null ? 'Create New' : 'Update'),
            )
          ],
        ),
      ),
    );
  }

  // Insert a new Membercard to the database
  Future<void> _addDatamembercard() async {
    await SQLHelper.createMembercard(
        _namaController.text,
        _tanggal_lahirController.text,
        _alamatController.text,
        _jenisKelamin!,
        _usernameController.text,
        _passwordController.text);
    _refreshDatamembercards();
  }

  // Update an existing Membercard by kode_member
  Future<void> _updateDatamembercard(int kode_member) async {
    await SQLHelper.updateDatamembercard(
        kode_member,
        _namaController.text,
        _tanggal_lahirController.text,
        _alamatController.text,
        _jenisKelamin!,
        _usernameController.text,
        _passwordController.text);
    _refreshDatamembercards();
  }

  // Delete a Membercard by id
  void _deleteDatamembercard(int kode_member) async {
    await SQLHelper.deleteDatamembercard(kode_member);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a Membercard!'),
    ));
    _refreshDatamembercards();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Admin Page'),
          backgroundColor: Colors.green[800],
        ),
        backgroundColor: Colors.green,
        body: ListView.builder(
          itemCount: _membercards.length,
          itemBuilder: (context, index) => Card(
            color: Colors.orange[200],
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Text(_membercards[index]['nama']),
              subtitle: Text(_membercards[index]['password']),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () =>
                          _showForm(_membercards[index]['kode_member']),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteDatamembercard(
                          _membercards[index]['kode_member']),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showForm(null),
          backgroundColor: Colors.green[700],
          child: const Icon(Icons.group_add),
        ),
      );
    }
  }
}
