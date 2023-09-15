
import 'package:car_app/src/models/car.dart';
import 'package:flutter/material.dart';

class ProviderAppCar extends ChangeNotifier{

  final List<Car> _car = [];

  List<Car> get cars => _car;

  void addCar(Car car){
    _car.add(car);
    notifyListeners();
  }

  void removeCar(Car car){
    _car.remove(car);
    notifyListeners();
  }
}