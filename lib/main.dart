import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/splash.dart';
import 'package:flutterrechargecount/services/auth.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_)=>Auth(),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(headline2: TextStyle(color: Colors.white), headline5: TextStyle(color: Colors.white))
        ),
        home: SplashScreen(),
      ),
    );
  }
}

