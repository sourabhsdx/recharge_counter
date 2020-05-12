
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showProgress =false;

  _signIn() async{
    setState(() {
      _showProgress = true;
    });
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    if(user!=null)
    {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
    builder: (context)=>HomePage()
    ));
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
              RaisedButton(onPressed: _signIn,
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
