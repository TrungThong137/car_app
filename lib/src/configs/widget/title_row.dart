import 'package:car_app/src/configs/widget/text_largest.dart';
import 'package:car_app/src/configs/widget/text_small.dart';
import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({super.key, 
    required this.textLeft, 
    required this.textRight, 
    required this.onTap
  });
  final String textLeft;
  final String textRight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
        TextLargest(text: textLeft),
        InkWell(
          onTap: onTap,
          child: TextSmall(text: textRight, fontWeight: FontWeight.bold,))
      ],
    );
  }
}