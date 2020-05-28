import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/landing_page.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
          builder: (context)=> LandingPage()
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.assignment,
        color: Colors.white,size: 100,),
        CircularProgressIndicator()
      ],
    );
  }
}
