import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/services/auth.dart';

class FloatingForm extends StatefulWidget {
  FloatingForm({this.auth});
  final AuthBase auth;
  @override
  _FloatingFormState createState() => _FloatingFormState();
}

class _FloatingFormState extends State<FloatingForm> {
  final Firestore _firestore = Firestore.instance;
  User _user;
  String _operator;
  String _number;
  double _amount;
  String _name="";

  getUser() async{
     _user = await widget.auth.currentUser();
    _name = _user.name;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();

  }
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        showModalBottomSheet(context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
            ),
            builder: (context){
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Operator"
                        ),
                          onChanged: (value){
                            _operator=value;
                          }
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Number"
                        ),
                        onChanged: (value){
                          _number=value;
                        },
                      ),
                      TextField(
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                            labelText: "Amount"
                        ), 
                          onChanged: (value){
                            _amount=double.parse(value);
                          }
                      ),
                      SizedBox(height: 10,),
                      RaisedButton(
                        onPressed: () async{
                          _firestore.collection('users/${_user.uid}/transactions').add({
                            'name':_name,
                            'number':_number,
                            'operator':_operator,
                            'amount':_amount
                          });
                          Navigator.of(context).pop();
                        },
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text("Add Transaction"
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}

