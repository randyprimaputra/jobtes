import 'package:flutter/material.dart';
import 'package:flutter_apk/components/my_appbar.dart';
import 'package:flutter_apk/pages/admin_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../db/database_instance.dart';
import '../model/membercard_model.dart';
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

  MemberCardModel? member;

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

  bool _isPasswordVisible = true;
  
  
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
                Icon(Icons.lock_person, size: 100, color: Colors.yellow[700]),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: _isPasswordVisible,
                    controller: passwordController,
                    decoration: InputDecoration(
                        enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green.shade400),
                            borderRadius: BorderRadius.circular(12)),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.black),
                        enabled: true,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility))),
                  ),
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
                        final members =
                            await databaseInstance.dataMembercard();
                        for (final m in members!) {
                          if (m.username == usernameController.text) {
                            member = m;
                            break;
                          }
                        }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return MemberPage(
                            member: member!,
                          );
                        }));
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Invalid username or password',
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.red,
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
