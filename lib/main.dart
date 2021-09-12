import 'package:flutter_auth/controller/login_controller.dart';
import 'package:flutter_auth/ui/sign_up.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LoginController(), child: LoginPage(),),
    ], 
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
    );
  }
}