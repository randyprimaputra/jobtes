import 'package:flutter/material.dart';
import 'package:flutter_apk/pages/admin_page.dart';

//import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminPage(),

      //masih terdapat eror
      //home: AdminPage(),
    );
  }
}
