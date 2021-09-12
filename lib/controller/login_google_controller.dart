import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController with ChangeNotifier {

  // obj
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  login() async {
    this.googleSignInAccount = await _googleSignIn.signIn();

    // call listener
    notifyListeners();
  }

  logout() async {
    // empty after logout
    this.googleSignInAccount = await _googleSignIn.signOut();

    // call listener
    notifyListeners();
  }
}