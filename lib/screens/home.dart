
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/models/transaction.dart';
import 'package:flutterrechargecount/screens/components/totalContainer.dart';
import 'package:flutterrechargecount/screens/components/transaction_item.dart';
import 'package:flutterrechargecount/screens/floating_screen.dart';
import 'package:flutterrechargecount/services/auth.dart';
import 'package:flutterrechargecount/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex =0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<Auth>(context);
    final Database firestore = Provider.of<FirestoreDatabase>(context);
    final User user = Provider.of<User>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: Icon(Icons.account_balance_wallet),
          backgroundColor: Colors.black,
          title: Text("Recharge Count"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => auth.signOut(),
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            children: <Widget>[
              StreamBuilder<List<TransactionClass>>(
                  stream: firestore.nonPaidStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final transactions = snapshot.data;
                      double total = 0;
                      for (TransactionClass transaction in transactions) {
                        total = total + transaction.amount;
                      }

                      return TotalBalance(total: total);
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Has Error"),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black12,
                      ),
                    );
                  }),
              StreamBuilder<List<TransactionClass>>(
                stream: firestore.transactionStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final transactions = snapshot.data;
                    List<Widget> _listElm = [];
                    for (TransactionClass transaction in transactions) {
                      final transWidget = TransactionItem(
                        tItem: transaction,
                        odd: _listElm.length % 2 == 0,
                      );
                      _listElm.add(transWidget);
                    }

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                          children: _listElm,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: Text("Error"),
                      ),
                    );
                  }
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black12,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingForm(
          user: user,
        ),

    );
  }
}
