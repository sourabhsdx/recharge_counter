
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/home.dart';
import 'package:flutterrechargecount/screens/login.dart';
import 'package:flutterrechargecount/services/auth.dart';



class LandingPage extends StatefulWidget {
  LandingPage({this.auth});
  final AuthBase auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;
  getUser() async{
    _user = await widget.auth.currentUser();
  }
  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: widget.auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return Login(auth: widget.auth,);
            }
            return HomePage(auth: widget.auth,user: _user,);
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
