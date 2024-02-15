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
        title: Text(
          'Edit note',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/note_list');
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _saveChanges,
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1BFFFF), Color(0xFF2E3192)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: 10,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
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
