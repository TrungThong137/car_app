import 'package:car_app/src/blocs/auth_bloc.dart';
import 'package:car_app/src/dialog/loading_dialog.dart';
import 'package:car_app/src/dialog/msg_dialog.dart';
import 'package:car_app/src/pages/home/home_page.dart';
import 'package:car_app/src/pages/login_page.dart';
import 'package:car_app/src/widget/button_page.dart';
import 'package:car_app/src/widget/text_largest.dart';
import 'package:car_app/src/widget/text_small.dart';
import 'package:car_app/src/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:car_app/src/widget/sidebar_login.dart';
import 'package:car_app/src/widget/social_icon.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = AuthBloc();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/app-icon0.png',
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'AutoTECH',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'write your own journey',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            ),
              const SizedBox(height: 50),
              const TextLargest(text: "Sign up Your Account"),
              const SizedBox(height: 30),
              TextFieldPage(
                  stream: authBloc.nameStream,
                  text: 'Name',
                  controller: _nameController,
                  icon: const Icon(
                    Icons.person_outline,
                    color: Colors.black26,
                  )),
              TextFieldPage(
                  stream: authBloc.emailStream,
                  text: 'Email',
                  controller: _emailController,
                  icon: const Icon(
                    Icons.mail_outline,
                    color: Colors.black26,
                  )),
              TextFieldPage(
                  stream: authBloc.phoneStream,
                  text: 'Phone Number',
                  controller: _phoneController,
                  icon: const Icon(
                    Icons.phone_outlined,
                    color: Colors.black26,
                  )),
              TextFieldPage(
                  stream: authBloc.passStream,
                  controller: _passController,
                  text: 'Password',
                  obscureText: true,
                  icon: const Icon(
                    Icons.lock_outlined,
                    color: Colors.black26,
                  )),
              ButtonPage(
                onTap: _onSignUpClicked,
                text: 'Sign up',
                color: Colors.black,
                colortext: Colors.white,
                width: double.maxFinite,
                height: 50,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SideBar(),
                  TextSmall(
                    text: '   or continue with   ',
                    color: Color.fromARGB(255, 98, 95, 95),
                  ),
                  // Text('   or continue with   '),
                  SideBar(),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialIcon(onTap: () {}, iconPath: 'assets/fb1.png'),
                    SocialIcon(onTap: () {}, iconPath: 'assets/gg1.png'),
                    SocialIcon(onTap: () {}, iconPath: 'assets/ios1.png')
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextSmall(
                    text: 'Already have an account? ',
                    color: Colors.black45,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: const TextSmall(
                        text: 'Sign in',
                        color: Colors.black,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUpClicked() {
    var isValid = authBloc.isValid(
        _nameController.text.toString().trim(),
        _emailController.text.toString().trim(),
        _phoneController.text.toString().trim(),
        _passController.text.toString().trim());
    if (isValid) {
      // create user
      // loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc.signUp(
          _emailController.text.toString().trim(),
          _passController.text.toString().trim(),
          _nameController.text.toString().trim(),
          _phoneController.text.toString().trim(), () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }, (msg) {
        // show msg dialog
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, 'Sign-In', msg);
      });
    }
  }
}
