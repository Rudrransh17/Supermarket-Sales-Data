import 'package:flutter/material.dart';

class CredentialTextfield extends StatelessWidget {
  final String text;
  final Icon icon;
  final TextEditingController controller;

  CredentialTextfield({required this.text, required this.icon,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: icon,
      ),
      cursorColor: Colors.blue,
      style: TextStyle(color: Colors.black),
    );
  }
}
