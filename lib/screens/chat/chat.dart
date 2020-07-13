import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterrechargecount/models/message.dart';
import 'package:flutterrechargecount/services/auth.dart';
import 'package:flutterrechargecount/services/database.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController message = new TextEditingController();
  bool canSend = true;
  @override
  Widget build(BuildContext context) {
    final AuthBase auth = Provider.of<Auth>(context);
    final Database database = Provider.of<FirestoreDatabase>(context);
    final User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.chat_bubble_outline),
        title: Text("Chat"),
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
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            _buildMessages(context),
            Container(
              color: Colors.white,
              padding:EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Flexible(child: TextFormField(
                    controller: message,
                    onChanged: (value){
                      if(value.isEmpty||value==null){
                        setState(() {
                          canSend = true;
                        });

                      }
                      else{
                        setState(() {
                          canSend = false;
                        });

                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0)
                      ),
                      hintText: "Message"
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue
                    ),
                    padding: EdgeInsets.all(12.0),
                      child: IconButton(icon:Icon(Icons.send),color: Colors.white,
                      onPressed: canSend?null:(){
                        if(message.text.isEmpty){
                          return;
                        }
                        Message _message = Message.fromJson({
                          'message':message.text,
                          'sender':user.name,
                          'senderId':user.uid,
                          'sentAt':Timestamp.now()
                        });
                        database.sendMessage(_message).then((value) => message.clear()).catchError((onError)=>print(onError.toString()));
                        print(message.text);
                      },
                      ))
                ],
              ),
            )

          ],
        ),
      ),
    );
  }


  Widget _buildMessages(BuildContext context){
    final Database database = Provider.of<FirestoreDatabase>(context);
    final User user = Provider.of<User>(context);
    return StreamBuilder<List<Message>>(
      stream: database.messageStream(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<Message> messages = snapshot.data;
          List<Widget> messageItem =[];
          for(Message m in messages){
            messageItem.add(Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: user.uid==m.senderId?Radius.circular(0.0):Radius.circular(8.0),topLeft: user.uid==m.senderId?Radius.circular(8.0):Radius.circular(0.0),bottomRight: Radius.circular(8.0),bottomLeft: Radius.circular(8.0)),
                color: user.uid==m.senderId?Colors.blue:Colors.green,
              ),
                child: Column(
                  crossAxisAlignment: user.uid==m.senderId?CrossAxisAlignment.end:CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(m.sender+':',style: TextStyle(fontSize: 8),textAlign: TextAlign.left,),
                    SelectableText(m.message,style: TextStyle(color: Colors.white),),
                  ],
                )
            ));
          }
          return  Expanded(
            child: ListView(
              reverse: true,
              children: messageItem,
            ),
          );
        }
        else if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        return  Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
