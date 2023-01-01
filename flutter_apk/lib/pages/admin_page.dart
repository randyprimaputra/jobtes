// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apk/pages/member/update_member_page.dart';
import '../db/database_instance.dart';
import './member/create_member_page.dart';
import '../model/membercard_model.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  DatabaseInstance? databaseInstance;

  Future _refresh() async {
    setState(() {});
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  Future deleteDataMemberCard(int kodeMember) async {
    await databaseInstance!.deleteDataMemberCard(kodeMember);
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (builder) {
                return CreateMemberPage();
              })).then((value) {
                setState(() {});
              });
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: databaseInstance != null
            ? FutureBuilder<List<MemberCardModel>?>(
                future: databaseInstance?.all(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('''Data Member Masih Kosong,\n' 
                      Silahkan isi data MemberCards terlebih dahulu!!'''),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(snapshot.data![index].name!),
                              subtitle: Text(snapshot.data![index].username!),
                              leading: const Icon(Icons.person),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (builder) {
                                            return UpdateMemberPage(
                                              memberCardModel:
                                                  snapshot.data![index],
                                            );
                                          })).then((value) {
                                            setState(() {});
                                          });
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton(
                                      onPressed: () => deleteDataMemberCard(
                                          snapshot.data![index].kodeMember!),
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    if (kDebugMode) {
                      print(snapshot.error);
                    }
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }
                },
              )
            : const CircularProgressIndicator(color: Colors.green),
      ),
    );
  }
}
