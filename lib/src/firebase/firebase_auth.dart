import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String password, String name, String phone,
      Function onSuccess, Function(String) onError) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        _createUser(user.user!.uid, name, phone, onSuccess, onError);
      });
    } on FirebaseAuthException catch (e) {
      onError('SignIn fail, please try again');
      if (e.code == 'weak-password') {
        onError('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onError) {
    var user = Map<String, String>();
    user['name'] = name;
    user['phone'] = phone;
    var ref = FirebaseDatabase.instance.ref().child('user');
    ref.child(userId).set(user).then((user) {
      onSuccess();
    }).catchError((err) {
      onError(err.toString());
    });
  }

  void signIn(String email, String password, Function onSuccess,
      Function(String) onError) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) {
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      onError('SignIn fail, please try again');
      if (e.code == 'user-not-found') {
        onError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  void signOut() async {
    return await _firebaseAuth.signOut();
  }
}
