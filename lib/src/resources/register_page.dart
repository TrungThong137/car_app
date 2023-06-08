import 'package:car_app/src/blocs/auth_bloc.dart';
import 'package:car_app/src/resources/dialog/loading_dialog.dart';
import 'package:car_app/src/resources/dialog/msg_dialog.dart';
import 'package:car_app/src/resources/home_page.dart';
import 'package:car_app/src/resources/login_page.dart';
import 'package:car_app/src/widget/button_page.dart';
import 'package:car_app/src/widget/text_largest.dart';
import 'package:car_app/src/widget/text_small.dart';
import 'package:car_app/src/widget/textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  AuthBloc authBloc= AuthBloc();
  final TextEditingController _nameController= TextEditingController();
  final TextEditingController _passController= TextEditingController();
  final TextEditingController _phoneController= TextEditingController();
  final TextEditingController _emailController= TextEditingController();

  @override
  void dispose(){
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff3277D8)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 200,
                margin: const EdgeInsets.only(top: 5),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT47gJJz7Qtjkth1BQXQDHPRebgb9LE4kcQKQ&usqp=CAU'),
                    fit: BoxFit.cover
                  )
                ),
              ),
              const SizedBox(height: 20,),
              const TextLargest(
                text: "Welcome Aboard!", 
              ),
              const SizedBox(height: 6,),
              const TextSmall(
                text: 'Signup with iCab in simple steps',
                color: Colors.black54, 
              ),
              const SizedBox(height: 20,),
              TextFieldPage(
                stream: authBloc.nameStream,
                text: 'Name',
                controller: _nameController,
                icon: const Icon(Icons.person_outline, color: Colors.black26,)
              ),
              TextFieldPage(
                stream: authBloc.phoneStream,
                text: 'Phone Number',
                controller: _phoneController,
                icon: const Icon(Icons.phone_outlined, color: Colors.black26,)
              ),
              TextFieldPage(
                stream: authBloc.emailStream,
                text: 'Email',
                controller: _emailController,
                icon: const Icon(Icons.mail_outline, color: Colors.black26,)
              ),
              TextFieldPage(
                stream: authBloc.passStream,
                controller: _passController,
                text: 'Password',
                obscureText: true,
                icon: const Icon(Icons.lock_outlined, color: Colors.black26,)
              ),
        
              ButtonPage(
                onTap: _onSignUpClicked,
                text: 'Signup', 
                color: Colors.blue, 
                colortext: Colors.white,
                width: double.maxFinite,
                height: 50,
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextSmall(text: 'Already a User? ', color: Colors.black45,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const LoginPage(),));
                    },
                    child: const TextSmall(text: 'Login now', color: Colors.blue,))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUpClicked(){
    var isValid = authBloc.isValid(
      _nameController.text.toString().trim(),
      _emailController.text.toString().trim(), 
      _phoneController.text.toString().trim(), 
      _passController.text.toString().trim()
    );
    if(isValid){
      // create user
      // loading dialog
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      authBloc.signUp(
        _emailController.text.toString().trim(), 
        _passController.text.toString().trim(),
        _nameController.text.toString().trim(),
        _phoneController.text.toString().trim(),
        (){
          LoadingDialog.hideLoadingDialog(context);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => const HomePage()));
        },
        (msg){
          // show msg dialog
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, 'Sign-In', msg);
        }
      );
    }
  }
}