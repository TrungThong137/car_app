import 'package:flutter/material.dart';

class TextSmall extends StatelessWidget {
  const TextSmall({super.key, 
    required this.text, 
    this.color=Colors.black});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: FontWeight.bold
      ),
    );
  }
}