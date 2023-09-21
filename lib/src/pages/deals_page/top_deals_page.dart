import 'package:car_app/src/models/car.dart';
import 'package:car_app/src/pages/home/components/information_car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopDealsPage extends StatefulWidget {
  const TopDealsPage({super.key});

  @override
  State<TopDealsPage> createState() => _TopDealsPageState();
}

class _TopDealsPageState extends State<TopDealsPage> {
  List _foundCar=[];
  int indexCompanyCar=0;

  @override
  void initState() {
    super.initState();
    _foundCar=informationCar;
  }

  Widget listCars(){
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 250
      ), 
      itemCount: _foundCar.length,
      itemBuilder: (context, index) => InformationCar(
        key: ValueKey(_foundCar[index].id),
        car: _foundCar[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: companyCar.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
                title: const Text(
                  'Top Deals',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset('assets/search.svg'),
                  )
                ],
            
              ),

              const SizedBox(height: 5,),
              
              TabBar(
                tabs: List.generate(companyCar.length, (index) => 
                  Container(
                    height: 30,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2)
                    ),
                    child: Text(companyCar[index].logoName),
                  ),
                ),
                isScrollable: true,
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                indicator: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                unselectedLabelColor: Colors.black,
              ),

              Expanded(
                child: TabBarView(
                  children: List.generate(companyCar.length, (index) => 
                    listCars()
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}