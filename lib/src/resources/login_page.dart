import 'package:car_app/src/blocs/auth_bloc.dart';
import 'package:car_app/src/resources/dialog/loading_dialog.dart';
import 'package:car_app/src/resources/dialog/msg_dialog.dart';
import 'package:car_app/src/resources/home_page.dart';
import 'package:car_app/src/resources/register_page.dart';
import 'package:car_app/src/widget/button_page.dart';
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
  AuthBloc authBloc=AuthBloc();
  final TextEditingController _passController= TextEditingController();
  final TextEditingController _emailController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 200,
              margin: const EdgeInsets.only(top: 100),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT47gJJz7Qtjkth1BQXQDHPRebgb9LE4kcQKQ&usqp=CAU'),
                  fit: BoxFit.cover
                )
              ),
            ),
            const SizedBox(height: 20,),
            const TextLargest(
              text: "Welcome back!", 
            ),
            const SizedBox(height: 6,),
            const TextSmall(
              text: 'Login to continue using iCab',
              color: Colors.black54, 
            ),
            const SizedBox(height: 60,),
            TextFieldPage(
              stream: authBloc.emailStream,
              controller: _emailController,
              text: 'Email',
              icon: const Icon(Icons.mail_outline, color: Colors.black26,)
            ),
            TextFieldPage(
              stream: authBloc.passStream,
              controller: _passController,
              text: 'Password',
              obscureText: true,
              icon: const Icon(Icons.phone_outlined, color: Colors.black26,)
            ),
            const Padding(
              padding: EdgeInsets.only(left: 190),
              child: TextSmall(text: 'Forgot password?', color: Colors.black38,),
            ),

            const SizedBox(height: 40,),

            ButtonPage(
              onTap: _onLoginClick,
              text: 'Log In', 
              color: Colors.blue, 
              colortext: Colors.white,
              width: double.maxFinite,
              height: 50,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextSmall(text: 'New user? ', color: Colors.black45,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const RegisterPage(),));
                  },
                  child: const TextSmall(text: 'Sign up for a new account', color: Colors.blue,))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onLoginClick(){
    LoadingDialog.showLoadingDialog(context, 'loading...');
    authBloc.signIn(
      _emailController.text.trim(),
      _passController.text.trim(),
      (){
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> const HomePage()));
      },
      (msg){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, 'Sign_In', msg);
      }
    );
  }
}