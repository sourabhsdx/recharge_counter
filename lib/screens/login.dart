
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/services/auth.dart';



class Login extends StatefulWidget {
  Login({this.auth});
  final AuthBase auth;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
   bool _showProgress =false;

  _signIn() async{
    setState(() {
      _showProgress = true;
    });
    try {
      await widget.auth.signInWithGoogle();
    }
    catch(e){
      _showProgress = false;
      print(e.toString());
    }
    setState(() {
      _showProgress = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(onPressed:_showProgress?null:_signIn,
                padding: EdgeInsets.all(20),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                color: Colors.blue,
                child: Text("Sign In",style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
              SizedBox(height: 30,),
              _showProgress?CircularProgressIndicator():Text("Sign In with Google")
            ],
        ),
      ),
    );
  }
}
