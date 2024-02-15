import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:note_app/services/api.dart';
import 'package:note_app/widgets/buttons.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final ApiService _apiService = ApiService();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _addNote() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'apiAccessToken');

    final title = _titleController.text;
    final content = _contentController.text;

    try {
      await _apiService.addNote(token!, title, content);
      final snackBar = SnackBar(
        content: Center(child: Text('Заметка добавлена')),
        duration: Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pushNamed(context, '/note_list');
    } catch (error) {
      print('Failed to add note: $error');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            BlueBtn(
              innerText: 'Add Note',
              buttonFunction: () async {
                _addNote();
              },
            ),
          ],
        ),
      ),
    );
  }
}
