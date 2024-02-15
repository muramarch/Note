import 'package:flutter/material.dart';
import 'package:note_app/services/api.dart';
import 'package:note_app/widgets/buttons.dart';
import 'package:note_app/widgets/textfields.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registration() async {
    final email = _emailController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      await _apiService.registerUser(email, username, password);

      Navigator.pushNamed(context, '/login');

      final snackBar = SnackBar(
        content: Center(child: Text('Успешная регистрация!')),
        duration: Duration(seconds: 3),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      print('Failed to register: $error');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                innerText: 'Enter your email',
                controller: _emailController,
              ),
              SizedBox(height: 20),
              SimpleTextfield(
                  innerText: 'Enter your username',
                  controller: _usernameController),
              SizedBox(height: 20),
              PasswordTexfield(
                  innerText: 'Enter your password',
                  controller: _passwordController),
              SizedBox(height: 20),
              BlueBtn(
                innerText: 'REGISTER',
                buttonFunction: _registration,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
