import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
class FireAuth{
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone,
    Function onSuccess, Function(String) onRegisterError)async {
      try {
        final credential=await _fireBaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass
        ).then((user) {
          _createUser(user.user!.uid, name, phone, onSuccess, onRegisterError);
        }); 
        print(credential.user.email);
      }on FirebaseAuthException catch (e) {
        _onSignUpErr(e.code, onRegisterError);
        if(e.code=='weak-password'){
          print('The password provided is too weak');
        }else if(e.code=='email-already-in-use'){
          print('The account already exists for that email.');
        }
      }catch(e){
        print(e);
      }
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) async{
    try {
      await _fireBaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
          onSuccess();
        });
    }on FirebaseAuthException catch (e) {
      onSignInError('Please try again');
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onRegisterError) {
    var user = Map<String, String>();
    user["name"] = name;
    user["phone"] = phone;

    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((vl) {
      print("on value: SUCCESSED");
      onSuccess();
    }).catchError((err) {
      print("err: " + err.toString());
      onRegisterError("SignUp fail, please try again");
    }).whenComplete(() {
      print("completed");
    });
  }

  ///
  void _onSignUpErr(String code, Function(String) onRegisterError) {
    print(code);
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("The password is not strong enough");
        break;
      default:
        onRegisterError("SignUp fail, please try again");
        break;
    }
  }

  Future<void> signOut() async {
    print("signOut");
    return _fireBaseAuth.signOut();
  }
}