import 'package:car_app/src/widget/text_small.dart';
import 'package:flutter/material.dart';

class CarCompany extends StatelessWidget {
  const CarCompany({super.key, 
    this.width=50, 
    this.isSelect=false, 
    required this.text, 
    required this.backgroundColor,
    required this.colorText
  });
  final double width;
  final bool isSelect;
  final String text;
  final Color backgroundColor;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: width,
      height: 27,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: backgroundColor ,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 2)
      ),
      child: TextSmall(
        text: text,
        color:colorText
      ),
    );
  }
}