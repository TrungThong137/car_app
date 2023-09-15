import 'package:flutter/material.dart';

class TextSmall extends StatelessWidget {
  const TextSmall({super.key, 
    required this.text, 
    this.color=Colors.black, 
    this.fontWeight=FontWeight.normal});
  final String text;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: color,
        fontWeight: fontWeight
      ),
    );
  }
}