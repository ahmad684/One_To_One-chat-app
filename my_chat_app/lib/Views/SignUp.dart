
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/Views/Sigin.dart';
import 'package:my_chat_app/Views/conversation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chat_app/authentication1/Sharedpref.dart';
import 'package:my_chat_app/authentication1/UserInfo.dart';
import 'package:my_chat_app/widget/apBar.dart';
SaveData _saveData=new SaveData();
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late FileImage _fileImage;
  var _formkey=GlobalKey<FormState>();
  FirebaseAuth _auth=FirebaseAuth.instance;
  XFile? _image;

  TextEditingController _name=new TextEditingController();
  TextEditingController _email=new TextEditingController();
  TextEditingController _password=new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  _imgFromCamera() async {
    var image = await _picker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
var image = await  _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }
  SignMEUp(){
    if(_formkey.currentState!.validate()){
      Map<String, dynamic> data = {
        'Name': _name.text.trim().toUpperCase(),
        'Email':_email.text.trim()

      };
      SharedPrefrencesData.setMyEmail(_email.text);
      SharedPrefrencesData.setMyName(_name.text);

      _auth.createUserWithEmailAndPassword(email: _email.text, password: _password.text).catchError((e){
        switch (e.toString()) {
          case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
            _showMyDialog(
                'User Already Registered',
                'Please check your email address carefully',
                'If your are not registered then contact  to admin');
            break;
          case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            _showMyDialog(
                'No Internet Connection',
                'Please connect your device to internet',
                '');
            break;
          case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
            _showMyDialog(
                'Request Blocked',
                'We are detect unusual Activity from this device',
                'Try again later');
            break;
          case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later. is not yet implemented':
            _showMyDialog(
                'Request Blocked',
                'We are detect unusual Activity from this device.',
                'Try again later!');
            break;
          case '[firebase_auth/user-disabled] The user account has been disabled by an administrator.':
            _showMyDialog(
                'User Blocked',
                'Your Blocked by Admin',
                'Please Contact to Admin');
            break;
          default:
            print(
                'Case $e is not yet implemented');
        }

      }).then((authResult) {
        if (authResult.user!.uid.isNotEmpty) {
          var user = _auth.currentUser;
          data['ID'] = user!.uid;
          _saveData.insertData(
              'User', data, user.uid);
          SharedPrefrencesData.setLogedIn(true);
          _showMyDialog(
              'Registration Successfully',
              'Now you are registered Successfully',
              'Thank for joining us').then((value) =>

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()))


          );



        }
      });




    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain('Sign Up'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(


              children: [
              Container(
                height: 70,
              ),
                Form(

                  key:_formkey,

                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,16.0,0,0),
                      child: TextFormField(

                        style: TextStyle(color: Colors.white),


                        decoration: InputDecoration(



                          hintText: 'Enter name',hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder:UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),



                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        controller: _name,

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,16.0,0,0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),


                        decoration: InputDecoration(



                          hintText: 'Enter Email',hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder:UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),




                        ),
                        validator: (value) {
          if (value!.isEmpty) {
          return 'This field is required';
          }
          if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
          ).hasMatch(value)) {
          return "a valid email like abc122@gmail.com";
          }
          },
                        controller: _email,

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,16.0,0,0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Enter Password',hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder:UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                          ),


                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be of 6 digits';
                          }
                          return null;
                        },
                        controller: _password,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: SizedBox(
                        height: 50,
                        width: 350,
                        child: ElevatedButton(onPressed: (){
                          SignMEUp();




                        }, child: Text('Sign Up'),
                            style:ElevatedButton.styleFrom(
                                primary:     Color(0xff145c9E),

                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)
                                )
                            )
                        ),
                      ),
                    )  ,
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                      child: SizedBox(
                        height: 50,
                        width: 350,
                        child: ElevatedButton(onPressed: (){}, child: Text('Sign Up with Google',style: TextStyle(color: Colors.black),),
                            style:ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(25)
                                )
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                          _name.clear();
                          _email.clear();
                          _password.clear();
                        },
                        child: Container(

                            child:  Text.rich(TextSpan(
                                style: TextStyle(color: Colors.white),
                                text: 'Already have an account?',
                                children: [
                                  TextSpan(
                                      text: 'Sign In',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline
                                      )
                                  )
                                ]
                            ))
                        ),
                      ),
                    )
                  ],

                ),

                )
              ],
            ),
          ),
        ),
      ),
    );

  }
  Future<void> _showMyDialog(String title, String msg1, var msg2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg1),
                Text(msg2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}

