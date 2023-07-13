import 'package:car_app/src/dialog/loading_dialog.dart';
import 'package:car_app/src/dialog/msg_dialog.dart';
import 'package:car_app/src/firebase/firebase_auth.dart';
import 'package:car_app/src/pages/main_page.dart';

import 'package:car_app/src/widget/button_page.dart';
import 'package:car_app/src/widget/text_largest.dart';
import 'package:car_app/src/widget/text_small.dart';
import 'package:car_app/src/widget/textfield_input.dart';
import 'package:flutter/material.dart';
import 'package:car_app/src/widget/sidebar_login.dart';
import 'package:car_app/src/widget/social_icon.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FireAuth _fireAuth = FireAuth();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnfController = TextEditingController();

  bool isName = true;
  bool isPass = true;
  bool isEmail = true;
  bool isPhone = true;
  bool isCnfPass = true;

  void _onSignUpClicked() {
    if (_nameController.text.isEmpty) {
      isName = false;
    } else {
      isName = true;
    }
    if (_passController.text.isEmpty || _passController.text.length < 6) {
      isPass = false;
    } else {
      isPass = true;
    }
    if (_cnfController.text != _passController.text) {
      isCnfPass = false;
    } else {
      isCnfPass = true;
    }
    if (_emailController.text.contains('@') &&
        _emailController.text.length > 6) {
      isEmail = true;
    } else {
      isEmail = false;
    }
    if (_phoneController.text.isEmpty || _phoneController.text.length < 9) {
      isPhone = false;
    } else {
      isPhone = true;
    }
    if (isCnfPass && isEmail && isPass && isName && isPhone) {
      // create user
      // loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      _fireAuth.signUp(
        _emailController.text.toString().trim(),
        _passController.text.toString().trim(),
        _nameController.text.toString().trim(),
        _phoneController.text.toString().trim(),
        () {
          LoadingDialog.hideLoadingDialog(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
        },
        (msg) {
          // show msg dialog
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, 'Sign-In', msg);
        },
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
              ),
              Image.asset(
                'assets/app-icon1.png',
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              const TextLargest(
                text: "Sign up Your Account",
              ),
              const SizedBox(
                height: 6,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldPage(
                text: 'Name',
                controller: _nameController,
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.black26,
                ),
                errorText: isName ? '' : 'Tên Không Được Để Trống',
              ),
              TextFieldPage(
                text: 'Phone Number',
                controller: _phoneController,
                icon: const Icon(
                  Icons.phone_outlined,
                  color: Colors.black26,
                ),
                errorText: isPhone ? '' : 'Số Điện Thoại Trên 9 số',
              ),
              TextFieldPage(
                text: 'Email',
                controller: _emailController,
                icon: const Icon(
                  Icons.mail_outline,
                  color: Colors.black26,
                ),
                errorText: isEmail ? '' : 'Email Phải có @',
              ),
              TextFieldPage(
                controller: _passController,
                text: 'Password',
                obscureText: true,
                icon: const Icon(
                  Icons.lock_outlined,
                  color: Colors.black26,
                ),
                errorText: isPass ? '' : 'Password có ít nhất 7 kí tự',
              ),
              TextFieldPage(
                controller: _cnfController,
                text: 'Confirm Password',
                obscureText: true,
                icon: const Icon(
                  Icons.lock_outlined,
                  color: Colors.black26,
                ),
                errorText: isCnfPass ? '' : 'Không Trùng Khớp Với Mật Khẩu',
              ),
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
                      Navigator.pop(context);
                    },
                    child: const TextSmall(
                      text: 'Sign in',
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
