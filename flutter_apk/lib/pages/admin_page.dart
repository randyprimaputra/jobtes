// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'member/update_member_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/db/database_instance.dart';
import 'member/create_member_page.dart';
import '/model/membercard_model.dart';

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

// Future deleteDataMemberCard(int kodeMember) async {
//   await databaseInstance!.deleteDataMemberCard(kodeMember);
//   setState(() {});a
//   Fluttertoast.showToast(
//     msg: 'Delete member success',
//   );
// }

  Future deleteDataMemberCard(int kodeMember) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('This action cannot be undone.'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () async {
              await databaseInstance!.deleteDataMemberCard(kodeMember);
              setState(() {});
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: 'Member has been deleted',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 2,
              );
            },
          ),
        ],
      ),
    );
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
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
        )),
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
                future: databaseInstance?.dataMembercard(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Data Member Masih Kosong'),
                          TextButton(
                            child: const Text('Add Member'),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (builder) {
                                return CreateMemberPage();
                              })).then((value) {
                                setState(() {});
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name.toString()),
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
                                      icon: Icon(Icons.edit),
                                      color: Colors.green),
                                  IconButton(
                                    onPressed: () => deleteDataMemberCard(
                                        snapshot.data![index].kodeMember!),
                                    icon: Icon(Icons.delete),
                                    color: Colors.red[700],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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
