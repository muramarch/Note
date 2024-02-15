import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:note_app/auth/authentication_screen.dart';
import 'package:note_app/auth/login_screen.dart';
import 'package:note_app/screens/note_add_screen.dart';
import 'package:note_app/screens/note_list_screen.dart';

void main() {
  runApp(Note());
}

class Note extends StatelessWidget {
  final String _token = '';

  Future<void> getToken() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'apiAccessToken');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      routes: {
        '/note_list': (context) => NoteListScreen(token: _token),
        '/note_add': (context) => AddNoteScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
