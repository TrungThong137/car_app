
import 'package:flutter/material.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key, 
   required this.text,
   required this.icon, 
   this.obscureText=false, 
   required this.controller, 
   this.errorText='', 
  });
  final String text;
  final Icon icon;
  final bool obscureText;
  final TextEditingController controller;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30, left: 30, bottom: 18),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black
        ),
        decoration: InputDecoration(
          errorText: errorText==''? null : errorText,
          labelText: text,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}