import 'package:flutter/material.dart';
import 'package:my_chat_app/widget/apBar.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain("About App"),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8,8,16),
                    child: Text('1.About This App',style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8,8,16),
                    child: Text('This is a one-to-one chat app through which you can simply signup and chat with friends',style: TextStyle(fontSize: 18,color: Colors.white))
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8,8,16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('2.How to signUp?',style: TextStyle(fontSize: 20,color: Colors.white)),
                        Text('To use this app first you have to  create an account with your name and Email account and then you login',style: TextStyle(fontSize: 18,color: Colors.white)),
                      ],
                    )
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,8,8,16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('2.How to signUp?',style: TextStyle(fontSize: 20,color: Colors.white)),
                          Text('After login you can search your friends and start chat. To chat with friend your friend must have an account on this app',style: TextStyle(fontSize: 18,color: Colors.white)),
                        ],
                      )
                  ),
                  Center(
                    child: Text("Best Of Luck we are looking for positive feedback from you"
                        "Thanks",style: TextStyle(fontSize: 20,color: Colors.white),),
                  )


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
