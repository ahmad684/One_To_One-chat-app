import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/Views/SignUp.dart';
import 'package:my_chat_app/Views/conversation.dart';
import 'package:my_chat_app/Views/forgotpassword.dart';
import 'package:my_chat_app/authentication1/Sharedpref.dart';
import 'package:my_chat_app/authentication1/UserInfo.dart';
import 'package:my_chat_app/widget/apBar.dart';
final FirebaseAuth _auth=FirebaseAuth.instance;
class SignIn extends StatefulWidget {

  const SignIn({Key? key}) : super(key: key);


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _fotmkey=GlobalKey<FormState>();
  bool isLoading=false;
SaveData _saveData=new SaveData();
  TextEditingController _email=new TextEditingController();
  TextEditingController _password=new TextEditingController();
late QuerySnapshot _querySnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBarMain('SignIn'),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(


              children: [
                Container(
                  height: 100,
                ),
                Form(
                  key: _fotmkey,
                  child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,26,0,0),
                      child: TextFormField(



                        style: TextStyle(color: Colors.white),

                        decoration: InputDecoration(



                          hintText: 'Enter Email',hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder:UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                          ),



                        ),validator: (value) {
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
                      padding: const EdgeInsets.fromLTRB(0,26,0,0),
                      child: TextFormField(

                        controller: _password,
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
                          }
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [


                            Text('Forgot Password?',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: SizedBox(
                        height: 50,
                        width: 350,
                        child: ElevatedButton(onPressed: (){
                         _signIn(_email.text, _password.text);

                      _password.clear();
                      _email.clear();



                        }, child: Text('Sign In'),
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
                        child: ElevatedButton(onPressed: (){}, child: Text('Sign In with Google',style: TextStyle(color: Colors.black),),
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                        child: Container(

                          child:  Text.rich(TextSpan(
                            style: TextStyle(color: Colors.white),
                            text: 'Don\'t have an account?',
                            children: [
                              TextSpan(
                                text: 'Register Now',
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
  void _signIn(String email, String password) async {
    try {
      if(_fotmkey.currentState!.validate()){



        SharedPrefrencesData.setMyEmail(_email.text);
        _saveData.getUserByEmail(_email.text).then((val){
          _querySnapshot=val;
          SharedPrefrencesData.setMyName(_querySnapshot.docs[0]["Name"]);

        });

        setState(() {
          isLoading=true;
        });



      await _auth
          .signInWithEmailAndPassword(
          email: email.trim(), password: password.trim())
          .then((task) {
        // go to home screen
        if (task.additionalUserInfo != null) {
          setState(() {
            SharedPrefrencesData.setLogedIn(true);

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChatRoom()));

          });
        }
      });}
    } catch (e) {
      switch (e.toString()) {
        case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
          _showMyDialog('Not Found', 'incorrect email.',
              'Please register first if you are new');
          break;
        case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
          _showMyDialog('Incorrect Password!', 'Please enter correct password',
              'or you can chose forgotten password option');
          break;
        case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          _showMyDialog('No Internet Connection',
              'Please connect your device to internet', '');
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
          _showMyDialog('User Blocked', 'Your Blocked by Admin',
              'Please Contact to Admin');
          break;
        default:
          print('Case $e is not yet implemented');
      }
      print('The error is $e');
    }
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
}
