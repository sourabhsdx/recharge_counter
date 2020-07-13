import 'package:flutter/material.dart';
import 'package:flutterrechargecount/screens/chat/chat.dart';
import 'package:flutterrechargecount/screens/home.dart';
import 'package:flutterrechargecount/services/auth.dart';

class TabScreen extends StatefulWidget {
  TabScreen({this.user});
  final User user;
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex =0;

  List<Widget> tabs = [HomePage(),ChatScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });

        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              title: Text("Chat")
          )
        ],

      ),
    );
  }
}

