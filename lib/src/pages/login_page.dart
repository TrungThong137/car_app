import 'package:car_app/src/blocs/auth_bloc.dart';
import 'package:car_app/src/dialog/loading_dialog.dart';
import 'package:car_app/src/dialog/msg_dialog.dart';
import 'package:car_app/src/pages/home/home_page.dart';
import 'package:car_app/src/pages/register_page.dart';
import 'package:car_app/src/widget/button_page.dart';
import 'package:car_app/src/widget/check_box.dart';
import 'package:car_app/src/widget/sidebar_login.dart';
import 'package:car_app/src/widget/social_icon.dart';
import 'package:car_app/src/widget/text_largest.dart';
import 'package:car_app/src/widget/text_small.dart';
import 'package:car_app/src/widget/textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc authBloc = AuthBloc();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
              const TextLargest(text: "Login to Your Account"),
              const SizedBox(height: 30),
              TextFieldPage(
                  stream: authBloc.emailStream,
                  controller: _emailController,
                  text: 'Email',
                  icon: const Icon(
                    Icons.mail_outline,
                    color: Colors.black26,
                  )),
              TextFieldPage(
                  stream: authBloc.passStream,
                  controller: _passController,
                  text: 'Password',
                  obscureText: true,
                  icon: const Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black26,
                  )),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CheckBox(),
                  SizedBox(width: 20),
                  TextSmall(
                    text: 'Forgot password?',
                    color: Colors.black38,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ButtonPage(
                onTap: _onLoginClick,
                text: 'Sign In',
                color: Colors.black,
                colortext: Colors.white,
                width: double.maxFinite,
                height: 50,
              ),
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
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextSmall(
                    text: 'Don\'t have an account? ',
                    color: Colors.black45,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ));
                    },
                    child: const TextSmall(
                      text: 'Sign up',
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginClick() {
    String email = _emailController.text.trim();
    String password = _passController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      MsgDialog.showMsgDialog(context, 'Error', 'Please try again');
      return;
    }

    LoadingDialog.showLoadingDialog(context, 'loading...');
    authBloc.signIn(_emailController.text.trim(), _passController.text.trim(),
        () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, 'Error', msg);
    });
  }
}
