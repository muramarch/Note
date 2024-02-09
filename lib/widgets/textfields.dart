import 'package:flutter/material.dart';

//Login texfield config
class SimpleTextfield extends StatefulWidget {
  final String innerText;
  final TextEditingController controller;

  const SimpleTextfield({required this.innerText, required this.controller});

  @override
  State<SimpleTextfield> createState() => _SimpleTextfieldState();
}

class _SimpleTextfieldState extends State<SimpleTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(0.0),
        ),
        hintText: widget.innerText,
      ),
    );
  }
}

//Password texfield config
class PasswordTexfield extends StatefulWidget {
  final String innerText;
  final TextEditingController controller;

  const PasswordTexfield({required this.innerText, required this.controller});

  @override
  State<PasswordTexfield> createState() => _PasswordTexfieldState();
}

class _PasswordTexfieldState extends State<PasswordTexfield> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isObscured,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(0.0),
        ),
        hintText: widget.innerText,
      ),
    );
  }
}
