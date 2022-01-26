import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefrencesData{
static String LogedIn="IsLogedin";
static String myname="mynamekey";
static String myemail="myemailkey";
static Future<bool>setLogedIn(bool isLogedIn)async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  return await sharedPreferences.setBool(LogedIn, isLogedIn);

}static Future<bool>setMyName(String name)async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  return await sharedPreferences.setString(myname, name);

}static Future<bool>setMyEmail(String Email)async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();  print(Email);
  return await sharedPreferences.setString(myemail, Email);

}

static Future GetLogedIn()async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  return sharedPreferences.getBool(LogedIn);

}static Future GetMyName()async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  return  sharedPreferences.getString(myname);

}static Future GetMyEmail()async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

  return sharedPreferences.getString(myemail);


}
static LogOut()async{

  FirebaseAuth.instance.signOut();



}
}