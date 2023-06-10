
import 'package:car_app/src/pages/preview_page.dart';
import 'package:car_app/src/widget/button_page.dart';
import 'package:flutter/material.dart';

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

  final welcomImg = 'assets/welcom-img.jpg';
  final appIcon = 'assets/app-icon0.png';
  final colorAppIcon = Colors.black; 

  void navigateSignUp(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return const PreviewPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(welcomImg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              const Text(
                'HI, WELCOM TO',
                style: TextStyle(
                  fontSize: 23,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,  
                children: [
                  Image.asset(appIcon, color: colorAppIcon),
                  const Text(
                    'AutoTECH',
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonPage(
                      onTap: () {
                        navigateSignUp(context);
                      },
                      text: 'Get started',
                      color: Colors.black,
                      colortext: Colors.white,
                      width: double.maxFinite,
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
