import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messanger/services/auth.dart';
import 'package:messanger/views/home.dart';
import 'package:messanger/views/signinScreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'messanger Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: AuthMethods().getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
          if (snapshot.hasData ){
            return Homepage();
          }else {
            return SigninPage();
          }
         },
      )
    );
  }
}
