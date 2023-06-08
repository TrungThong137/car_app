import 'package:flutter/material.dart';

class TextLargest extends StatelessWidget {
  const TextLargest({super.key, 
    required this.text,
    this.color=Colors.black});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color
      ),
    );
  }
}