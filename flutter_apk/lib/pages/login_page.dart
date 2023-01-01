import 'package:flutter/material.dart';
import 'package:flutter_apk/components/my_appbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Login Page',),
    );
  }
}