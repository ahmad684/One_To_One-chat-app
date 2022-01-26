import 'package:flutter/material.dart';
import 'package:my_chat_app/authentication1/Sharedpref.dart';

import 'package:splash_screen_view/SplashScreenView.dart';

import '../main.dart';
import 'Sigin.dart';
import 'conversation.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool IsuserLogedIn=false;
  @override
  void initState() {
    // TODO: implement initState
    GetUserLogedin();
    super.initState();
  }
  GetUserLogedin()async{

    await SharedPrefrencesData.GetLogedIn().then((value){
      setState(() {
        IsuserLogedIn=value;

      });
    });
  }
  Widget build(BuildContext context) {
    Widget example2 = SplashScreenView(

      duration: 5000,
      imageSize: 400,
      imageSrc: "asset/images/chat_icon.png",

      textType: TextType.ColorizeAnimationText,

      backgroundColor: Color(0xff1F1F1f), navigateRoute:IsuserLogedIn?ChatRoom():SignIn(),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash screen Demo',
      theme: ThemeData(

          primaryColor: Color(0xff145c9E),
          scaffoldBackgroundColor: Color(0xff1F1F1f)
      ),
      home: example2,
    );
  }
}