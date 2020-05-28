
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/home.dart';
import 'package:flutterrechargecount/screens/login.dart';
import 'package:flutterrechargecount/services/auth.dart';
import 'package:flutterrechargecount/services/database.dart';
import 'package:provider/provider.dart';



class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<Auth>(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return Login();
            }
            return Provider(
              create: (_)=>FirestoreDatabase(uid: user.uid),
                child: HomePage(user: user,));
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
