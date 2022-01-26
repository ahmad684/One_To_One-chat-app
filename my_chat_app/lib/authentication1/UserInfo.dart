import 'package:cloud_firestore/cloud_firestore.dart';

class SaveData {
  final db = FirebaseFirestore.instance;
  void insertData(String col, Map<String, dynamic> data, [var id]) {
    if (id != null) {
      db.collection(col).doc(id).set(data);
    } else {
      db.collection(col).add(data);
    }
    //print(db.collection(col).get());
  }
  getUser(String Byname)async{
    return  await FirebaseFirestore.instance.collection("User").where("Name",isEqualTo: Byname).get();
  }getUserByEmail(String ByEmail)async{
    return  await FirebaseFirestore.instance.collection("User").where("Email",isEqualTo: ByEmail).get();
  }
  CreatChatRoom(String chatRoomID,ChatRoomMAp){
    db.collection("ChatRoom").doc(chatRoomID).set(ChatRoomMAp).catchError((e){
      print(e.toString());
    });
  }
  addConversationMessges(String chatRoomID,MessageMap){
    db.collection("ChatRoom").doc(chatRoomID).collection("chats").add(MessageMap).catchError((e){
      print(e.toString());
    });

  }



}