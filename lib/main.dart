import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(headline2: TextStyle(color: Colors.white), headline5: TextStyle(color: Colors.white))
      ),
      home: SplashScreen(),
    );
  }
}

