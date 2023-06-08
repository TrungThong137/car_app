import 'package:car_app/src/blocs/auth_bloc.dart';
import 'package:car_app/src/firebase/firebase_auth.dart';
import 'package:car_app/src/models/infor_drawer.dart';
import 'package:car_app/src/pages/login_page.dart';
import 'package:car_app/src/widget/infor_card.dart';
import 'package:car_app/src/pages/home/slide_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 
  int selectedIndex=-1;
  final FireAuth _fireAuth= FireAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu), color: Colors.black,
              onPressed: (){
                  _scaffoldKey.currentState!.openDrawer();
              },
            ),
            title: const Text('App', style: TextStyle(color: Colors.black),),
            centerTitle: true,
            actions: const[
              Icon(Icons.notifications, color: Colors.amber,)
            ],
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(250, 74, 12, 1),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InfoCard(
                  name: "Abu Anwar",
                  profession: "YouTuber",
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text(
                    "Browse".toUpperCase(),
                    style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70)
                    ,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Divider(
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),

                Wrap(
                  children: List.generate(inforDrawer.length, (index) {
                    if(index+2<inforDrawer.length){
                      return SlideMenuTitle(
                        icon: inforDrawer[index].icon,
                        text: inforDrawer[index].text,
                        index: index,
                        selectedIndex: selectedIndex,
                        ontap: (){
                          setState(() {
                            selectedIndex=index;
                          });
                        },
                      );
                    }else{
                      return SizedBox(height: 200,
                        child: SlideMenuTitle(
                          icon: inforDrawer[index].icon,
                          text: inforDrawer[index].text,
                          index: index,
                          selectedIndex: selectedIndex,
                          ontap: (){
                            setState(() {
                              selectedIndex=index;
                              _fireAuth.signOut();
                            });
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> const LoginPage()));
                          },
                        ),
                      );
                    }
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<InforDrawer> inforDrawer=[
  InforDrawer(icon: Icons.home_outlined, text: 'Home'),
  InforDrawer(icon: Icons.search, text: 'Search'),
  InforDrawer(icon: Icons.star_outline, text: 'Star'),
  InforDrawer(icon: Icons.favorite_outline, text: 'Heart'),
  InforDrawer(icon: Icons.logout, text: 'Log out'),
];