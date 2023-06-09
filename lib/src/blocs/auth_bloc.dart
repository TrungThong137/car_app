
import 'dart:async';

import 'package:car_app/src/firebase/firebase_auth.dart';

class AuthBloc{
  final _fireAuth= FireAuth();

  final StreamController _nameController= StreamController();
  final StreamController _emailController= StreamController();
  final StreamController _passController= StreamController();
  final StreamController _phoneController= StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get phoneStream => _phoneController.stream;

  bool isValid(String name, String email, String phone, String pass){
    if(name.isEmpty ){
      _nameController.sink.addError('Nhap Ten');
      return false;
    }
    _nameController.sink.add('');
    if(email.isEmpty){
      _emailController.sink.addError('Nhap Email');
      return false;
    }
    _emailController.sink.add('');
    if(phone.isEmpty){
      _phoneController.sink.addError('Nhap SDT');
      return false;
    }
    _phoneController.sink.add('');
    if(pass.isEmpty || pass.length < 6){
      _passController.sink.addError('Nhap Password phai tren 6 ki tu');
      return false;
    }
    _passController.sink.add('');
    return  true;
  }

  void signUp(String email, String password, String name, String phone, 
    Function onSuccess, Function(String) onError){
    _fireAuth.signUp(email, password, name, phone, onSuccess, onError);
  }

  void signIn(String email, String password, 
    Function onSuccess, Function(String) onError){
    _fireAuth.signIn(email, password, onSuccess, onError);
  }

  void dispose(){
    _emailController.close();
    _nameController.close();
    _phoneController.close();
    _passController.close();
  }
}