import 'package:flutter/material.dart';
import 'package:messanger/services/auth.dart';
import 'package:messanger/views/signinScreen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isSearching = false;
  TextEditingController searchEditingController = TextEditingController();
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
                    isSearching?
                    GestureDetector(
                      onTap: (){
                        isSearching =false;
                        searchEditingController.text = "";

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_back_rounded),
                      ),
                    ):Container(),
                    
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 1.0),
                                borderRadius: BorderRadius.circular(24)
                                ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchEditingController,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: "Username",),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  isSearching = true;
                                  setState(() {
                                   // isSearching = true;
                                  });
                                },
                                child: Icon(Icons.search_rounded)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
