import 'package:flutter/material.dart';
import 'package:messanger/services/auth.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({ Key? key }) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Messanger"),
        centerTitle: false,
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            AuthMethods().singInWithGoogle(context);
          },
          child: Container(
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(20),
              color: Colors.pink
            ),
           // color: Colors.pink,
            child: Text("Signin with Google",textAlign: TextAlign.center ,style: TextStyle(fontSize: 25.0),),
          ),
        )
      ),
    );
  }
}