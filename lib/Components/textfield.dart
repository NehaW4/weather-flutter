import 'dart:ffi';

import 'package:flutter/material.dart';
import '../Constants.dart' as constant;


class textfield extends StatelessWidget {
  final String text;
  final bool isPassword;

  final Function(String) onChanged;
  const textfield({
    super.key, required this.text, required this.isPassword, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: constant.textSecondary),
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: constant.textSecondary,
            fontSize: 15.0,
            fontWeight: FontWeight.w200,
            // fontStyle: FontStyle.italic,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: constant.textSecondary,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}