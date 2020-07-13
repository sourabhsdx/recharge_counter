import 'package:flutter/material.dart';
import 'package:flutterrechargecount/models/transaction.dart';
import 'package:flutterrechargecount/services/database.dart';
import 'package:provider/provider.dart';


class TransactionItem extends StatelessWidget {
  TransactionItem({this.tItem, this.odd});
  final TransactionClass tItem;
  final bool odd;
  
   Future<void> deleteWithAlert(BuildContext context,Database firebase){
    return showDialog(context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to delete?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            FlatButton(
              child: Text('Delete'),
              onPressed: () {
               firebase.deleteTransaction(tItem.docId);
               Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
  }
  
  
  @override
  Widget build(BuildContext context) {
    final Database firebase = Provider.of<FirestoreDatabase> (context);
    return GestureDetector(
      onLongPress: (){
        deleteWithAlert(context,firebase);
      },
      child: Material(
        color: odd?Colors.black12:Colors.white,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: CheckboxListTile(
          secondary: Text("${tItem.amount}"),
          title: Column(
            children: <Widget>[
              Text("+91${tItem.number}"),
              Text("${tItem.operator}")
            ],
          ),
          subtitle: Wrap(
            spacing: 10.0,
            children: <Widget>[
              Text("${tItem.name}"),
              Text("${tItem.time.toDate().toLocal().toString()}",style: TextStyle(color: Colors.blue),)
            ],
          ),
          value: tItem.paid??true,
          onChanged: (value){
            firebase.updateTransaction(tItem.docId);

          },
        ),
      ),
    );
  }
}
