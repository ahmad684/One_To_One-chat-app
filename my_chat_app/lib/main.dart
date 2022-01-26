import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/Views/Sigin.dart';
import 'package:my_chat_app/Views/SignUp.dart';
import 'package:my_chat_app/Views/SplashScreen.dart';
import 'package:my_chat_app/Views/conversation.dart';
import 'package:my_chat_app/authentication1/Sharedpref.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
        theme: ThemeData(

            primaryColor: Color(0xff145c9E),
            scaffoldBackgroundColor: Color(0xff1F1F1f)
        ),
      home:SplashScreen()
    );
  }
}

