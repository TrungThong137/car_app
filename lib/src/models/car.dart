
class Car{
  String discount;
  String imageCar;
  String logoName;
  String name;
  String price;
  Car({
    this.discount='', this.imageCar='',
    this.logoName='', this.name='',
    this.price=''
  });
}

List car=[
  Car(discount: '20%', imageCar: 'assets/g63.png'),
  Car(discount: '20%', imageCar: 'assets/ddds.png'),
  Car(discount: '20%', imageCar: 'assets/f-15.png'),
  Car(discount: '20%', imageCar: 'assets/fiat-min-van.png'),
  Car(discount: '20%', imageCar: 'assets/range.png'),
];

List logoCar=[
  Car(logoName: 'Mercedes', imageCar: 'assets/mercedes-logo.png'),
  Car(logoName: 'Tesla', imageCar: 'assets/-teslaicon.png'),
  Car(logoName: 'BMW', imageCar: 'assets/bmw-icon.png'),
  Car(logoName: 'Toyota', imageCar: 'assets/Toyota-logo.png'),
  Car(logoName: 'Volvo', imageCar: 'assets/volvo_logo.png'),
  Car(logoName: 'Bugatti', imageCar: 'assets/bugatti_logo.png'),
  Car(imageCar: 'assets/honda_logo.png', logoName: 'Honda'),
  Car(logoName: 'More', imageCar: 'assets/more-circle.png'),
];

List companyCar=[
  Car(logoName: 'All'),
  Car(logoName: 'Mercedes'),
  Car(logoName: 'Tesla'),
  Car(logoName: 'BMW'),
  Car(logoName: 'Toyota'),
  Car(logoName: 'Volvo'),
  Car(logoName: 'Bugatti'),
  Car(logoName: 'Honda'),
];

List informationCar=[
  Car(name: 'Mercedes G63', imageCar: 'assets/g63.png', price: '\$200,000'),
  Car(name: 'DDDS', imageCar: 'assets/ddds.png', price: '\$150,000'),
  Car(name: 'F-15', imageCar: 'assets/f-15.png', price: '\$170,000'),
  Car(name: 'Fiat Min Van', imageCar: 'assets/fiat-min-van.png', price: '\$190,000', ),
  Car(name: 'Range', imageCar: 'assets/range.png', price: '\$100,000'),
  Car(name: 'Toyota Corolla Sedan', imageCar: 'assets/Toyota-Corolla-Sedan-2019_2020.png', price: '\$190,000'),
  Car(name: 'Benz', imageCar: 'assets/benz.png', price: '\$150,000'),
];