import 'package:flutter/material.dart';

import 'package:note_app/auth/authentication_screen.dart';

void main() {
  runApp(Note());
}

class Note extends StatelessWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
    );
  }
}
