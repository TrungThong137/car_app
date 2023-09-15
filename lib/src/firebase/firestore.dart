
import 'package:car_app/src/models/car.dart';
import 'package:car_app/src/models/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore{
  static Stream<List<Car>> readCar() => FirebaseFirestore.instance
    .collection('car').snapshots()
    .transform(Utils.tranformer((Car.fromJson)));

  static Stream<List<Car>> readNewspaper() => FirebaseFirestore.instance
      .collection("car")
      .snapshots()
      .transform(Utils.tranformer((Car.fromJson)));
  
}