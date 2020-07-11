import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/models/transaction.dart';
import 'package:flutterrechargecount/screens/floating_screen.dart';
import 'package:flutterrechargecount/services/auth.dart';
import 'package:flutterrechargecount/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({this.user});
  final User user;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Firestore _firestore = Firestore.instance;
  double _total = 0.00;

  void getTotal() async{
   final transactions = await _firestore.collection('users/${widget.user.uid}/transactions').getDocuments();
   double totalBal = 0.0;
   for(var transaction in transactions.documents){
     totalBal = totalBal +double.parse(transaction.data['amount'].toString());
   }
   setState(() {
     _total = totalBal;
   });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotal();
  }
  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<Auth>(context);
    final Database firestore = Provider.of<FirestoreDatabase>(context);
    return Scaffold(
        backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.account_balance_wallet),
        backgroundColor: Colors.black,
        title: Text("Recharge Count"),
        actions: <Widget>[
          FlatButton(
            onPressed: ()=>auth.signOut(),
            child: Text("Logout",style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: 200,

              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                color: Colors.blue,
                elevation: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30,),
                    Text("Total:",style: Theme.of(context).textTheme.headline5,),
                    SizedBox(height: 10,),
                    Text("Rs. $_total",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.1),)
                  ],
                ),
              ),
            ),
            StreamBuilder<List<TransactionClass>>(
              stream: firestore.transactionStream(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  final transactions = snapshot.data;
                  List<Widget> _listElm = [];
                  for(TransactionClass transaction in transactions)
                    {
                      final String name = transaction.name;
                      final String operator = transaction.operator;
                      final String number = transaction.number;
                      final String amount = transaction.amount.toString();
                      bool value = transaction.paid??false;
                      final transWidget =  Material(
                        color: _listElm.length%2==0?Colors.black12:Colors.white,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                        ),
                        child: CheckboxListTile(
                          secondary: Text("$amount"),
                          title: Column(
                            children: <Widget>[
                              Text("+91$number"),
                              Text("$operator")
                            ],
                          ),
                          subtitle: Text("$name"),
                         value: value,
                          onChanged: (value){
                            setState(() {
                              value = value;
                            });
                          },
                        ),
                      );

                      _listElm.add(transWidget);
                    }
                  getTotal();

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: _listElm,
                      ),
                    ),
                  );

                }
                else if(snapshot.hasError){
                  print("has error");
                }
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(backgroundColor: Colors.black12,),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton:
        FloatingForm(user: widget.user,)
    );
  }
}

