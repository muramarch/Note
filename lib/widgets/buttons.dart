import 'package:flutter/material.dart';

class TransparentBtn extends StatefulWidget {
  final String innerText;
  final Function BtnFunc;

  const TransparentBtn({required this.innerText, required this.BtnFunc});

  @override
  State<TransparentBtn> createState() => _TransparentBtnState();
}

class _TransparentBtnState extends State<TransparentBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          widget.BtnFunc();
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 3, color: Color(0xFF2E3192)),
        ),
        child: Text(
          widget.innerText,
          style: TextStyle(
              color: Color(0xFF2E3192),
              fontSize: 15,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class BlueBtn extends StatefulWidget {
  final String innerText;
  final Function buttonFunction;

  const BlueBtn({required this.innerText, required this.buttonFunction});

  @override
  State<BlueBtn> createState() => _BlueBtnState();
}

class _BlueBtnState extends State<BlueBtn> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1BFFFF), Color(0xFF2E3192)],
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        onTap: () {
          widget.buttonFunction();
        },
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          constraints: BoxConstraints(
            minWidth: 88.0,
            minHeight: 36.0,
          ),
          alignment: Alignment.center,
          child: Text(
            widget.innerText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
