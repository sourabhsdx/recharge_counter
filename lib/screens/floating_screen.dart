import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/models/transaction.dart';
import 'package:flutterrechargecount/services/auth.dart';
import 'package:flutterrechargecount/services/database.dart';
import 'package:provider/provider.dart';

class FloatingForm extends StatefulWidget {
  FloatingForm({this.user});
  final User user;
  @override
  _FloatingFormState createState() => _FloatingFormState();
}

class _FloatingFormState extends State<FloatingForm> {
  String _operator;
  String _number;
  double _amount;

  void _addTxn(Database firestore,BuildContext context) async {
    await firestore.addTransaction(TransactionClass.fromJson({
      'name': widget.user.name,
      'uid':widget.user.uid,
      'number': _number,
      'operator': _operator,
      'amount': _amount,
      'paid': false,
      'time': Timestamp.now()
    },""));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Database _firestore =
        Provider.of<FirestoreDatabase>(context, listen: false);
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                          decoration: InputDecoration(labelText: "Operator"),
                          onChanged: (value) {
                            _operator = value;
                          }),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Number"),
                        onChanged: (value) {
                          _number = value;
                        },
                      ),
                      TextField(
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(labelText: "Amount"),
                          onChanged: (value) {
                            _amount = double.parse(value);
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () => _addTxn(_firestore,context),
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text("Add Transaction"),
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
