import 'package:flutter/material.dart';

class TextLargest extends StatelessWidget {
  const TextLargest({super.key, 
    required this.text,
    this.color=Colors.black, 
    this.fontSize=20});
  final String text;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color
      ),
    );
  }
}