import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:note_app/screens/note_add_screen.dart';
import 'package:note_app/screens/note_detail_screen.dart';
import 'package:note_app/screens/note_edit_screen.dart';

import 'package:note_app/screens/profile_screen.dart';
import 'package:note_app/services/api.dart';

class NoteListScreen extends StatefulWidget {
  final String token;

  const NoteListScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late ApiService _apiService = ApiService();
  late List<Map<String, dynamic>> _notes = [];
  late List<Map<String, dynamic>> _filteredNotes = [];
  late FlutterSecureStorage _secureStorage;

  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _secureStorage = new FlutterSecureStorage();
    _searchController = TextEditingController();
    //Функция, которая достает список заметок из бд
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    try {
      String token =
          (await _secureStorage.read(key: 'apiAccessToken')).toString();
      final notes = await _apiService.getNotes(token);
      setState(() {
        _notes = notes;
        _filteredNotes = notes;
      });
    } catch (error) {
      print('Ошибка ${error}');
    }
  }

  void _deleteNote(int id) async {
    try {
      String token =
          (await _secureStorage.read(key: 'apiAccessToken')).toString();
      await _apiService.deleteNote(token, id);

      final snackBar = SnackBar(
        content: Center(child: Text('Заметка удалена!')),
        duration: Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //Обновление списка заметок после удаления
      _fetchNotes();
    } catch (error) {
      print('Ошибка при удалении заметки: ${error}');
    }
  }

  void _searchNotes(String value) {
    setState(() {
      _filteredNotes = _notes
          .where((note) =>
              note['title'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNoteScreen()),
            );
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: Icon(Icons.person),
            color: Colors.white,
          ),
        ],
        title: Text(
          'Note List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchNotes,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Поиск',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            child: _buildNoteList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteList() {
    if (_filteredNotes.isEmpty) {
      return Center(
        child: Text('No notes available.'),
      );
    }

    return ListView.builder(
      itemCount: _filteredNotes.length,
      itemBuilder: (context, index) {
        final note = _filteredNotes[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NoteDetailScreen(note: note)),
            );
          },
          child: Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note['title'],
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      note['created_at'],
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700]),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteEditScreen(
                                token: widget.token,
                                noteId: note['id'],
                                title: note['title'],
                                content: note['content'],
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          _deleteNote(note['id']);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[300],
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
