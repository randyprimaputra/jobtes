import 'package:flutter/material.dart';
import 'package:flutter_apk/components/my_appbar.dart';
import 'package:flutter_apk/pages/admin_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../db/database_instance.dart';
import 'member/member_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final databaseInstance = DatabaseInstance();

  Future<void> _getStoredCredentials() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if (username == null || password == null) {
      prefs.setString('username', 'ADMIN');
      prefs.setString('password', 'ADMIN');
    }
  }

  @override
  void initState() {
    super.initState();
    _getStoredCredentials().then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Login Page',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Icon(Icons.lock_person, size: 100, color: Colors.green),
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
                  controller: usernameController,
                  hintText: 'Username',
                  obsecureText: false,
                ),

                const SizedBox(height: 10),
                // password textfield
                MyTextField(
                  controller: passwordController,
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
                  onTap: () async {
                    final bool loginSuccess = await databaseInstance.login(
                      usernameController.text,
                      passwordController.text,
                    );
                    if (loginSuccess) {
                      if (usernameController.text == 'ADMIN' &&
                          passwordController.text == 'ADMIN') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return const AdminPage();
                        }));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return MemberPage(
                            username: usernameController.text,
                            password: passwordController.text,
                          );
                        }));
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Invalid username or password',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM);
                    }

                    const SizedBox(height: 10);
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
                    );
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
