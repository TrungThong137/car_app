import 'package:car_app/src/widget/text_largest.dart';
import 'package:car_app/src/widget/text_small.dart';
import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({super.key, 
    required this.textLeft, 
    required this.textRight
  });
  final String textLeft;
  final String textRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        TextLargest(text: textLeft),
        TextSmall(text: textRight, fontWeight: FontWeight.bold,)
      ],
    );
  }
}