import 'package:flutter/material.dart';
import 'package:flutter_apk/components/my_button.dart';
import 'package:flutter_apk/components/my_textfield.dart';
import 'package:flutter_apk/pages/admin_page.dart';
import 'package:flutter_apk/pages/adminlogin_page.dart';
import 'package:flutter_apk/pages/member_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_apk/controller/membercard_controller.dart';
import 'package:flutter_apk/model/membercard_model.dart';

import '../db/sql_helper.dart';

class LoginPage extends StatefulWidget {
    final SQLHelper sqlHelper;
  final MembercardController membercardController;
    LoginPage({Key key, this.sqlHelper, this.membercardController}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState(sqlHelper: sqlHelper, membercardController: membercardController);
}

// login member


class _LoginPageState extends State<LoginPage> {

  // text editing controllers

_LoginPageState({this.sqlHelper, this.membercardController});

  // Create an instance of SQLHelper and MembercardController
  final sqlHelper = SQLHelper();
  final membercardController = MembercardController(sqlHelper: sqlHelper);

  // Sign userAdmin in method
  void signUserIn() async {
    // Get the entered username and password
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Check the user's credentials using the membercardController
    List<MembercardModel> membercards = await widget.membercardController.login(username, password);
    bool isValid = membercards.isNotEmpty;
    if (isValid) {
      // Navigate to the appropriate page based on the user's role
      if (username == 'Admin' && password == 'Admin') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AdminPage()));
      } else {
        // Query the database for the user's data
        // Navigate to the member page
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MemberPage(
                      userName: username, passWord: password,
                    )));
      }
    } else {
      // Display an error message
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Incorrect username or password"),
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
      backgroundColor: Colors.green,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Icon(Icons.lock_person, size: 100, color: Colors.white),
                // Hello again !
                Text(
                  'Login',
                  style: GoogleFonts.bebasNeue(fontSize: 36),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Required ',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 50),

                // username textfield
                // ignore: prefer_const_constructors
                MyTextField(
                  controller: _usernameController,
                  hintText: 'Username',
                  obsecureText: false,
                ),

                const SizedBox(height: 10),
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
                        'Forgot Password?',
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Not have account? ',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Ask your Administrator for register',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

// function untuk masuk ke admin page ketika tidak memiliki akun admin
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminLoginPage()));
        },
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.admin_panel_settings),
      ),
    );
  }
}
