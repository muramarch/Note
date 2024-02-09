import 'package:flutter/material.dart';
import 'package:note_app/widgets/buttons.dart';
import 'package:note_app/widgets/textfields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

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
              PasswordTexfield(
                innerText: 'Repeat your password',
                controller: _passwordConfirmController,
              ),
              SizedBox(height: 20),
              BlueBtn(
                innerText: 'REGISTER',
                buttonFunction: () {},
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
