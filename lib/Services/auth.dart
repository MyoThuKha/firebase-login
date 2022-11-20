import 'package:brew_crew/Models/user_model.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get custom user id from firebaseauth data.
  UserModel _getUId(User? user) {
    return user != null ? UserModel(uid: user.uid) : null!;
  }

  //get Stream
  Stream<UserModel> get userStream {
    return _auth.authStateChanges().map(_getUId);
  }

  //Sign in as Anonymous
  Future signAsAnys() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _getUId(user);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  //Sign in with email
  Future logIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _getUId(result.user);
    } catch (e) {
      // print(e.toString());
      String error = e.toString();
      error = error.substring(error.indexOf('/'), error.indexOf(']'));
      return error;
    }
  }

  //Register
  Future createAccount(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //create dbase when register
      await DatabaseService(uid: user!.uid)
          .updateUserData('new member', false, [], [], 0);

      return _getUId(user);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  //for update password
  Future changePassword(String password) async {}
  //Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
