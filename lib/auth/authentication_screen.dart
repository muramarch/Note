import 'package:flutter/material.dart';
import 'package:note_app/auth/login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: Image.asset('assets/images/notelogo.png'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50, // Отступ снизу
            left: 0,
            right: 0,
            child: Center(
                child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Continue',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AuthScreen(),
  ));
}
