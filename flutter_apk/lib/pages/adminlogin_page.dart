import 'package:flutter/material.dart';
import 'package:flutter_apk/components/my_button.dart';
import 'package:flutter_apk/components/my_textfield.dart';
import 'package:flutter_apk/pages/admin_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _LoginPageState();
}

// admin

class _LoginPageState extends State<AdminLoginPage> {
  // text editing controllers
  final _passwordController = TextEditingController();

  // Sign userAdmin in method
  void signUserIn() async {
    // Get the  password
    String password = _passwordController.text;

    // Navigate to Admin Page with password match
    if (password == 'ADMIN') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AdminPage()));
    } else {
      // Display an error message
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("password"),
              actions: <Widget>[
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Admin Login Page'),
      ),
      backgroundColor: Colors.green,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Icon(Icons.lock_person, size: 100, color: Colors.white),
                // Hello Admin !
                Text(
                  'Enter',
                  style: GoogleFonts.bebasNeue(fontSize: 36),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Password ',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obsecureText: true,
                ),
                const SizedBox(height: 10),

                // forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'default password is ADMIN',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                // sign in button
                MyButton(
                  onTap: signUserIn,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
