
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/services/auth.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
   bool _showProgress =false;

  _signIn(BuildContext context) async{
    final AuthBase _authBase = Provider.of<Auth>(context,listen: false);
    setState(() {
      _showProgress = true;
    });
    try {
      await _authBase.signInWithGoogle();
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
              RaisedButton(onPressed:_showProgress?null:()=>_signIn(context),
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
