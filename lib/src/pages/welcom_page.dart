// import 'package:car_app/src/pages/login_page.dart';
import 'package:car_app/src/pages/preview_page.dart';
import 'package:car_app/src/widget/button_page.dart';
import 'package:flutter/material.dart';

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/welcom-img.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 15),
              const Text(
                'HI, WELCOM TO',
                style: TextStyle(
                  fontSize: 35,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              // Image.asset('assets/app-icon1.png', color: Colors.black),
              const Text(
                'AutoTECH',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // const Text('The best car marketplace app for your journey'),
                    // const SizedBox(height: 15),
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
              // ButtonPage(
              //   color: Colors.black,
              //   text: 'Get started',
              //   onTap: () {
              //     navigateSignUp(context);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
