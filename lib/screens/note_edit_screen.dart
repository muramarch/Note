import 'package:flutter/material.dart';
import 'package:note_app/services/api.dart';

class NoteEditScreen extends StatefulWidget {
  final String token;
  final int noteId;
  final String title;
  final String content;

  const NoteEditScreen({
    Key? key,
    required this.token,
    required this.noteId,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
    _apiService = ApiService();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    String token = widget.token;
    String title = _titleController.text;
    String content = _contentController.text;

    try {
      await _apiService.editNote(token, widget.noteId, title, content);

      setState(() {
        title = title;
        content = content;
      });

      Navigator.pushNamed(context, '/note_list');
    } catch (error) {
      print('Failed to edit note: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
        actions: [
          IconButton(
            onPressed: _saveChanges,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Content',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
