import 'package:flutter/material.dart';

class TotalBalance extends StatelessWidget {
  TotalBalance({this.total});
  final double total;
  @override
  Widget build(BuildContext context) {
    return  Container(
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
            Text("Not Paid:",style: Theme.of(context).textTheme.headline5,),
            SizedBox(height: 10,),
            Text("Rs. $total",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.1),)
          ],
        ),
      ),
    );
  }
}
