import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/floating_screen.dart';
import 'package:flutterrechargecount/services/auth.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth});
  final AuthBase auth;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Firestore _firestore = Firestore.instance;
  double _total = 0.00;

  void getTotal() async{
   final transactions = await _firestore.collection('transactions').getDocuments();
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
    return Scaffold(
        backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Icon(Icons.account_balance_wallet),
        backgroundColor: Colors.black,
        title: Text("Recharge Count"),
        actions: <Widget>[
          FlatButton(
            onPressed: ()=>widget.auth.signOut(),
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
                    Text("Rs. $_total",style: Theme.of(context).textTheme.headline2,)
                  ],
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('transactions').snapshots(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  final transactions = snapshot.data.documents;
                  List<Widget> _listElm = [];
                  double totalAmount =0.00;
                  for(var transaction in transactions)
                    {
                      final String name = transaction.data['name'];
                      final String operator = transaction.data['operator'];
                      final String number = transaction.data['number'];
                      final String amount = transaction.data['amount'].toString();
                      final transWidget =  Material(
                        color: _listElm.length%2==0?Colors.black12:Colors.white,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.attach_money),
                          title: Column(
                            children: <Widget>[
                              Text("+91$number"),
                              Text("$operator")
                            ],
                          ),
                          subtitle: Text("$name"),
                          trailing: Text("$amount"),
                        ),
                      );

                      _listElm.add(transWidget);
                    }
                  getTotal();

                  return Expanded(
                    child: ListView(
                      children: _listElm,
                    ),
                  );

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
        FloatingForm()
    );
  }
}

