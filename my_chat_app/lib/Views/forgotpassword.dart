import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/widget/apBar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  FirebaseAuth auth = FirebaseAuth.instance;
  var _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarMain('Reset Password'),
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [

                    Padding(
                        padding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
                        child: TextFormField(
                            controller: email,

                            style: TextStyle(color: Colors.white),

                            decoration: InputDecoration(



                                hintText: 'Enter Email',hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder:UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)
                                ),

                                labelText: 'Email:',
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(value)) {
                                return "a valid email like abc122@gmail.com";
                              }
                            })),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size.fromHeight(50)),

                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                reset(email.text.trim());
                              }
                            },
                            child: Text(
                              'Reset',
                              style: TextStyle(fontSize: 18),
                            ))),
                  ],
                ))));
  }

  void reset(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) {
        if (auth.currentUser?.uid != '') {
          _showMyDialog('Password Reset Successfully',
              'Please check your email', 'Password reset link sent');
          Navigator.pop(context);
        }
      });

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      switch (e.toString()) {
        case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
          _showMyDialog('Donor not Registered', 'Please registered as donor.',
              'If you are registered! Please Enter Correct email');
          break;
        case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
          _showMyDialog('Incorrect Password!', 'Please enter correct password',
              'or you can chose forgotten password option');
          break;
        case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          _showMyDialog('No Internet Connection',
              'Please connect your device to internet', '');
          break;
        default:
          print('Case $e is not yet implemented');
      }
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
