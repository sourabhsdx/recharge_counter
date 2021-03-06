
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/home.dart';
import 'package:flutterrechargecount/screens/login.dart';
import 'package:flutterrechargecount/screens/tabScreen.dart';
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
            return MultiProvider(
              providers: [
                Provider<FirestoreDatabase>(create: (_)=>FirestoreDatabase(uid: user.uid)),
                Provider<User>(create: (_)=>User(uid: user.uid,name: user.name),)
              ],
                child: TabScreen());
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
