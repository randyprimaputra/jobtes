import 'package:flutter/material.dart';

import '../../components/my_appbar.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    // Use the username and password here as needed
    return Scaffold(
      appBar: const MyAppBar(title: 'Member Page'),
      body: Container(),
    );
  }
}
