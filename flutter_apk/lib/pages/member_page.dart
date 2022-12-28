import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {
  final String userName;
  const MemberPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add your member page content here
      body: Center(
        child: Text('Welcome, $userName'),
      ),
    );
  }
}
