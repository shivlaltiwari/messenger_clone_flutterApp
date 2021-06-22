import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messanger/HelperFunction/shared_preference.dart';
import 'package:random_string/random_string.dart';
class ChatScreen extends StatefulWidget {
  final String ChatWithUserName, name;
  ChatScreen({ required this.ChatWithUserName, required this.name});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String ChatRoomId, messageId;
  late String myProfilePic, Myusername, Myname, MyEmail;
  TextEditingController messagesTextController = TextEditingController();
  getMyInfoFromSharedPreferences()async{
    Myname =  (await sharedPreferenceHelper().getDisplayName())! ;
    myProfilePic = (await sharedPreferenceHelper().getUserPrifile())!;
    Myusername = (await sharedPreferenceHelper().getUserName())!;
    MyEmail = (await sharedPreferenceHelper().getUserEmail())!;
    ChatRoomId = getChatRoomIdByUserName(widget.ChatWithUserName, Myusername);


  }
  getChatRoomIdByUserName( String a, String b){
    if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    } else{
      return "$a\_$b";
    }
  }

  addMessage( bool sendClicked){
    if(messagesTextController != ""){
      String message = messagesTextController.text;

      var lastMessageTs = DateTime.now();

      Map <String , dynamic> messageInfoMap= {
        "message":message,
        "SendBy":Myusername,
        "ts":lastMessageTs,
        "imgUrl": myProfilePic
      };
      // ignore: unnecessary_null_comparison
      if(messageId == null){
        messageId = randomAlphaNumeric(12);

      }

    }

  }

  getAndSetMessage(){}

  dothisOnLunch() async{
    await getMyInfoFromSharedPreferences();
    getAndSetMessage();
  }
  @override
  void initState() {
    super.initState();
    dothisOnLunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
            
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: Colors.grey,
                child: Row(
                  children: [
                    Expanded(child: TextField(
                      controller: messagesTextController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type Message",
                        hintStyle: TextStyle(fontWeight: FontWeight.bold)
                      ),
                    )),
                    Icon(Icons.send_rounded,size: 25.0,color: Colors.black,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}