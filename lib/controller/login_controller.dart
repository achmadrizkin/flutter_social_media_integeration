import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/models/user_details.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController with ChangeNotifier {
  // obj
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;

  // func for google login
  googleLogin() async {
    this.googleSignInAccount = await _googleSignIn.signIn();

    // insert val to userDetails model
    this.userDetails = new UserDetails(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,
    );

    notifyListeners();
  }

  // func for facebook login
  facebookLogin() async {
    var result =
        await FacebookAuth.i.login(permissions: ["public_profile", "email"]);

    // check status login
    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );

      this.userDetails = new UserDetails(
          displayName: requestData["name"],
          email: requestData["email"],
          photoURL: requestData["picture"]["data"]["url"] ?? "");

      notifyListeners();
    }
  }

  logOut() async {
      // empty after logout
      this.googleSignInAccount = await _googleSignIn.signOut();
      await FacebookAuth.i.logOut();

      userDetails = null;

      // call listener
      notifyListeners();
    }
}
