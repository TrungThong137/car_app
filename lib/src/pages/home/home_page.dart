import 'dart:async';

import 'package:car_app/src/models/car.dart';
import 'package:car_app/src/widget/car_company.dart';
import 'package:car_app/src/widget/discount_car.dart';
import 'package:car_app/src/widget/information_car.dart';
import 'package:car_app/src/widget/logocar.dart';
import 'package:car_app/src/widget/text_largest.dart';
import 'package:car_app/src/widget/text_small.dart';
import 'package:car_app/src/widget/textfile_search.dart';
import 'package:car_app/src/widget/title_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _controller = PageController(initialPage: 0);
  int isIndex=0;
  bool isActive=false;
  int indexCompanyCar=0;
  int currentIndex=0;
  late Timer timer;

  @override
  void initState(){
    super.initState();
    autoShowCar();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    _controller.dispose();
  }

  void autoShowCar(){
    timer = Timer.periodic(
      const Duration(seconds: 2), (timer) { 
      if(currentIndex<car.length-1){
        currentIndex++;
      }else{
        currentIndex=0;
      }
      _controller.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 200), 
        curve: Curves.bounceInOut
      );
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children:[
            Container(
              margin: const EdgeInsets.only(top: 250, left: 20, right: 20),
              width: double.maxFinite,
              height: 200,
              child: PageView.builder(
                controller: _controller,
                itemCount: car.length,
                itemBuilder: (context, index) => DiscountCar(
                  discount: car[index].discount, 
                  imageCar: car[index].imageCar
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(vertical: 430, horizontal: 150),
              child: SmoothPageIndicator(
                controller: _controller, 
                count: car.length,
                effect: const ExpandingDotsEffect(
                  spacing: 12,
                  dotColor: Colors.grey,
                  strokeWidth: 1,
                  dotWidth: 7,
                  dotHeight: 7,
                  activeDotColor: Colors.black
                ),
                onDotClicked: (index) => _controller.animateToPage(
                  index, 
                  duration: const Duration(milliseconds: 500), 
                  curve: Curves.linear
                ),
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 50,),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.brown,
                  ),
                  contentPadding: const EdgeInsets.only(left: 18, right: 20),
                  title: const TextSmall(text: 'Welcome Back', color: Colors.black54,),
                  subtitle: const TextLargest(text: 'Andrew Ainsley'),
                  trailing: SizedBox(
                    width: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/notification-bing.svg'),
                        const SizedBox(width: 12,),
                        SvgPicture.asset('assets/heart.svg'),
                      ],
                    ),
                  )
                ),
          
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      const TextFieldSearch(), 
                
                      const SizedBox(height: 20,),
                      const TitleRow(textLeft: "Special Offsers", 
                        textRight: 'See All'
                      ),
          
                      const SizedBox(height: 230,),
          
                      logoCars(),

                      const TitleRow(
                        textLeft: 'Top Deals', 
                        textRight: 'See All'
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 20 ),
                        height: 30,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: companyCar.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                indexCompanyCar=index;
                              });
                            },
                            child: CarCompany(
                              colorText: indexCompanyCar==index ? Colors.white : Colors.black,
                              text: companyCar[index].logoName,
                              backgroundColor: indexCompanyCar==index ? Colors.black : Colors.white,
                              width: 100,
                            ),
                          )
                        ),
                      ),


                      SizedBox(
                        height: 500,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 250
                          ), 
                          itemCount: informationCar.length,
                          itemBuilder: (context, index) => InformationCar(
                            car: informationCar[index],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50,)
                    ],
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }

  Widget logoCars(){
    return SizedBox(
      height: 230,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 91
        ),
        itemCount: logoCar.length,
        itemBuilder: (context, index) => LogoCar(
          logoCar: logoCar[index].imageCar, 
          nameCar: logoCar[index].logoName
        ),
      ),
    );
  }
}
