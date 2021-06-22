import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messanger/HelperFunction/shared_preference.dart';
import 'package:messanger/services/auth.dart';
import 'package:messanger/services/database.dart';
import 'package:messanger/views/chatscreen.dart';
import 'package:messanger/views/signinScreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isSearching = false;
  TextEditingController searchEditingController = TextEditingController();
  Stream? userStrem;
  late String myProfilePic, Myusername, Myname, MyEmail;
  getMyInfoFromSharedPreferences()async{
    Myname =  (await sharedPreferenceHelper().getDisplayName())! ;
    myProfilePic = (await sharedPreferenceHelper().getUserPrifile())!;
    Myusername = (await sharedPreferenceHelper().getUserName())!;
    MyEmail = (await sharedPreferenceHelper().getUserEmail())!;
  }
  getChatRoomIdByUserName( String a, String b){
    if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    } else{
      return "$a\_$b";
    }
  }

  onSearchbtnClick() async {
    isSearching = true;
    setState(() {
      // isSearching = true;
    });
    userStrem = await DatabaseMethod()
        .getUserByUserName(searchEditingController.text.trim());
    setState(() {});
  }

  Widget searchListUserTile(String profileUrl, name, email) {
    return GestureDetector(
      onTap: () {
        var ChatRoomId = getChatRoomIdByUserName(Myusername=
        'shiva', name);
        print("the name is $Myusername and $name");
        Map<String , dynamic> chatRoomInfoMap ={
          "user":[Myusername, name],
        };
        DatabaseMethod().createChatRoom(ChatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      name: email,
                      ChatWithUserName: name,
                    )));
      },
      child: Card(
        color: Colors.lightGreen,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Image.network(profileUrl),
              title: Text(
                name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(email),
            )
          ],
        ),
      ),
    );
  }

  Widget searchUserList() {
    print("object");
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("user")
            .where("name", isEqualTo: searchEditingController.text.trim())
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return searchListUserTile(
                        ds['imgUrl'], ds['name'], ds['email']);
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
  @override
  void initState() {
   
    super.initState();
   getMyInfoFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fake Messanger"),
          centerTitle: false,
          actions: [
            InkWell(
              onTap: () {
                AuthMethods().signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SigninPage()));
                });
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.exit_to_app_rounded),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    isSearching
                        ? GestureDetector(
                            onTap: () {
                              isSearching = false;
                              searchEditingController.text = "";
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.arrow_back_rounded),
                            ),
                          )
                        : Container(),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1.0),
                            borderRadius: BorderRadius.circular(24)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchEditingController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    // ignore: unnecessary_null_comparison
                                    if (searchEditingController != null) {
                                      onSearchbtnClick();
                                      //searchUserList();
                                    }
                                  },
                                  child: Icon(Icons.search_rounded)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                searchUserList(),
              ],
            ),
          ),
        ));
  }
}
