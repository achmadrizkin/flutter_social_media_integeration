import 'package:flutter/material.dart';
import 'package:flutter_auth/controller/login_controller.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Consumer<LoginController>(
      builder: (context, models, child) {
        // if we already logged in
        if (models.userDetails != null) {
          return Center(
            child: loggedInUI(models),
          );
        } else {
          return loginController(context);
        }
      },
    )));
  }

  loginController(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          FlutterLogo(size: 180),
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hey there\nWelcome back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Login to your account to continue',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ),
          Spacer(),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
              onPressed: () {
                final provider =
                    Provider.of<LoginController>(context, listen: false);
                provider.googleLogin();
              },
              label: Text('Sign up with Google')),
          SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.red),
              onPressed: () {
                final provider =
                    Provider.of<LoginController>(context, listen: false);
                provider.facebookLogin();
              },
              label: Text('Sign up with Facebook')),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                text: 'Already have a account? ',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Log in',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  loggedInUI(LoginController model) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Profile',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 40,
            backgroundImage:
                Image.network(model.userDetails!.photoURL ?? "").image,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            model.userDetails!.displayName ?? "",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            model.userDetails!.email ?? "",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 8,
          ),
          ActionChip(
              avatar: Icon(Icons.logout),
              onPressed: () {
                Provider.of<LoginController>(context, listen: false).logOut();
              },
              label: Text("Logout")),
        ],
      ),
    );
  }

}
