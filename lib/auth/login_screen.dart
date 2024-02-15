import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:note_app/auth/registration_screen.dart';
import 'package:note_app/screens/note_list_screen.dart';
import 'package:note_app/services/api.dart';
import 'package:note_app/widgets/buttons.dart';
import 'package:note_app/widgets/textfields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService _apiService = ApiService();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final response = await _apiService.loginUser(username, password);
      final token = response['auth_token'];

      final storage = new FlutterSecureStorage();
      await storage.write(key: 'apiAccessToken', value: token);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NoteListScreen(token: token),
        ),
      );
    } catch (error) {
      print('Login failed: $error');

      final snackBar = SnackBar(
        content: Center(child: Text('Неверный логин или пароль!')),
        duration: Duration(seconds: 3),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              Container(
                width: 70,
                child: Image.asset('assets/images/notelogoblack.png'),
              ),
              SizedBox(height: 20),
              SimpleTextfield(
                innerText: 'Enter your username',
                controller: _usernameController,
              ),
              SizedBox(height: 20),
              PasswordTexfield(
                innerText: 'Enter your password',
                controller: _passwordController,
              ),
              SizedBox(height: 20),
              BlueBtn(
                  innerText: 'LOG IN',
                  buttonFunction: () {
                    _login();
                  }),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Please',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[700],
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' register ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.indigo,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(),
                            ),
                          );
                        },
                    ),
                    TextSpan(
                      text: 'if you do not have account.',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
