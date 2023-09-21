import 'package:car_app/src/pages/home/components/information_car.dart';
import 'package:flutter/material.dart';

class CarCompany extends StatelessWidget {
  const CarCompany({super.key, 
    required this.foundCar
  });
  final List foundCar;

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 250
      ), 
      itemCount: foundCar.length,
      itemBuilder: (context, index) => InformationCar(
        key: ValueKey(foundCar[index].id),
        car: foundCar[index],
      ),
    );
  }
}