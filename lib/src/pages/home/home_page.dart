
import 'dart:async';

import 'package:car_app/src/firebase/firestore.dart';
import 'package:car_app/src/models/car.dart';
import 'package:car_app/src/pages/deals_page/top_deals_page.dart';
import 'package:car_app/src/configs/widget/discount_car.dart';
import 'package:car_app/src/configs/widget/information_car.dart';
import 'package:car_app/src/configs/widget/logocar.dart';
import 'package:car_app/src/configs/widget/text_largest.dart';
import 'package:car_app/src/configs/widget/text_small.dart';
import 'package:car_app/src/configs/widget/textfile_search.dart';
import 'package:car_app/src/configs/widget/title_row.dart';
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
  Timer? timer;

  List _foundCar=[];

  @override
  void initState(){
    super.initState();
    // autoShowCar();
    _foundCar=informationCar;
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    _controller.dispose();
  }

  void _runFilter(String enteredKeyword){
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = informationCar;
    } else {
      results = informationCar
        .where((user) =>
        user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
        .toList();
    }
    setState(() {
      _foundCar=results;
    });
  }

  // void autoShowCar(){
  //   timer = Timer.periodic(
  //     const Duration(seconds: 2), (timer) { 
  //     if(currentIndex<car.length-1){
  //       currentIndex++;
  //     }else{
  //       currentIndex=0;
  //     }
  //     _controller.animateToPage(
  //       currentIndex,
  //       duration: const Duration(milliseconds: 200), 
  //       curve: Curves.bounceInOut
  //     );
  //   });
  // } 

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
    return Scaffold(
      body: DefaultTabController(
        length: companyCar.length,
        child: SingleChildScrollView(
          child: Stack(
            children:[
              Container(
                margin: const EdgeInsets.only(top: 250, left: 20, right: 20),
                width: double.maxFinite,
                height: 200,
                child: StreamBuilder(
                  stream: FireStore.readNewspaper(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return Stack(
                        children:[
                          PageView.builder(
                            controller: _controller,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final car= snapshot.data![index];
                                return DiscountCar(
                                  imageCar: car.imageCar,
                                  discount: car.discount,
                                );
                            },
                          ),

                          Positioned(
                            bottom: 20,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 130),
                              child: SmoothPageIndicator(
                                controller: _controller, 
                                count: snapshot.data!.length,
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
                          ),
                        ] 
                      );
                    }else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
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
      
                        TextFieldSearch(
                          onChange: (value) => _runFilter(value),
                        ), 
                  
                        const SizedBox(height: 20,),
                        TitleRow(textLeft: "Special Offsers", 
                          textRight: 'See All',
                          onTap: (){},
                        ),
            
                        const SizedBox(height: 230,),
            
                        logoCars(),
      
                        TitleRow(
                          textLeft: 'Top Deals', 
                          textRight: 'See All',
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>const TopDealsPage()));
                          },
                        ),

                        const SizedBox(height: 20,),
      
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

                        SizedBox(
                          height: 500,
                          child: TabBarView(
                            children: List.generate(companyCar.length, (index) => 
                              listCars()
                            )
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
