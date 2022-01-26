import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthMethod{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  Future signUp(String name,String email,String password) async {
    try{

  UserCredential result= await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());

    }catch(e){
      print(e);


    }


  }


}