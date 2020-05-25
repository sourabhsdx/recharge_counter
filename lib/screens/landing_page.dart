
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/home.dart';
import 'package:flutterrechargecount/screens/login.dart';
import 'package:flutterrechargecount/services/auth.dart';



class LandingPage extends StatelessWidget {
  LandingPage({this.auth});
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return Login(auth: auth,);
            }
            return HomePage(auth: auth,);
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
