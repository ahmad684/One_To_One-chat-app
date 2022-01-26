import 'package:flutter/material.dart';
import 'package:my_chat_app/widget/apBar.dart';
class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain('Contact Us'),
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              Image.asset("asset/images/gd.jpg"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'GROWING DEVELOPERS',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 5,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                   color: Color(0xff145c9E),
                    borderRadius: BorderRadius.circular(15.0)),
                child: GestureDetector(

                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'ahmadkalloka@gmail.com',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                height: 80,
                width: 330,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xff145c9E),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '+923094435197',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                height: 80,
                width: 330,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
