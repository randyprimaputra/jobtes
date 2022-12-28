import 'package:flutter/material.dart';
import 'package:flutter_apk/pages/admin_page.dart';
import 'package:flutter_apk/pages/login_page.dart';

//import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

//  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      //masih terdapat eror
      //home: AdminPage(),
    );
  }
}
