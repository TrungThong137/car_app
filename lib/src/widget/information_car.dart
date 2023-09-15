import 'package:car_app/src/models/car.dart';
import 'package:car_app/src/provider_app/provier_app_car.dart';
import 'package:car_app/src/widget/discount_car.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformationCar extends StatefulWidget {
  const InformationCar({super.key,
    required this.car,
  });
  final Car car;

  @override
  State<InformationCar> createState() => _InformationCarState();
}

class _InformationCarState extends State<InformationCar> {

  int gottenStars=4;

  @override
  Widget build(BuildContext context) {

    final cars= context.watch<ProviderAppCar>().cars;

    return Consumer<ProviderAppCar>(
      builder: (context, carProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children:[
              DiscountCar(
                imageCar: widget.car.imageCar,
                isText: false,
                width: 180,
                height: 150,
                widthCar: 150,
              ),
    
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: (){
                    if(!cars.contains(widget.car)){
                      carProvider.addCar(widget.car);
                    }else{
                      carProvider.removeCar(widget.car);
                    }
                  }, 
                  icon: cars.contains(widget.car) ? const Icon(Icons.favorite, 
                    color: Colors.red
                  ): const Icon(Icons.favorite_border, color: Colors.black,)
                ),
              )
    
            ] 
          ),
          const SizedBox(height: 10,),
          Text(
            widget.car.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Wrap(
                children: List.generate(5, (index) => InkWell(
                  onTap: (){
                    setState(() {
                      gottenStars=index+1;
                    });
                  },
                  child: Icon(
                    Icons.star,
                    color: index<gottenStars? Colors.yellow : Colors.grey,
                  ),
                )),
              ),
              const SizedBox(width: 5,),
              Text(
                "($gottenStars.0)",
                style: const TextStyle(
                  color: Colors.blueAccent
                ),
              ),
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              Container(
                width: 50,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.grey.withOpacity(0.12)
                ),
                child: const Text('New',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const SizedBox(width: 5,),
              Container(
                width: 1,
                height: 15,
                color: Colors.black,
              ),
              const SizedBox(width: 5,),
              Text(
                widget.car.price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}