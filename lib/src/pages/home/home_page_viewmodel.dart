import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/models/car.dart';

class HomePageViewModel extends BaseViewModel{
  List<Car> listCar=[];
  dynamic init(){}

  void addCar(Car car){
    listCar.add(car);
    notifyListeners();
  }

  void removeCar(Car car){
    listCar.remove(car);
    notifyListeners();
  }
}