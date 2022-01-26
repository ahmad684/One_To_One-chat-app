import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/authentication1/Constants.dart';
import 'package:my_chat_app/authentication1/UserInfo.dart';
import 'package:my_chat_app/widget/apBar.dart';

import 'SearchScreen.dart';
SaveData _saveData=new SaveData();
class Conversation extends StatefulWidget {
  String chatRoomId;
  Conversation(this.chatRoomId);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  TextEditingController _messagecontroller=new TextEditingController();
  ScrollController _scrollController=new ScrollController();


  Widget chatMessageList(){

    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(

          stream:db.collection("ChatRoom").doc(widget.chatRoomId).collection("chats").orderBy("Time",descending: false).snapshots(),
          builder: (context,snapshot){

        return snapshot.hasData?ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,

            physics: NeverScrollableScrollPhysics(),

            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              return MessageTile(snapshot.data!.docs[index]["Message"],snapshot.data!.docs[index]["SendBy"]==Constants.MyName);

            }):CircularProgressIndicator();



      }),
    );
  }
void ScrolDown(){
    final double end=_scrollController.position.minScrollExtent;
    _scrollController.jumpTo(end);
}
  sendMessage(){
    if(_messagecontroller.text.isNotEmpty){
      Map<String,dynamic> MessageMap={

        "Message":_messagecontroller.text,
        "SendBy":Constants.MyName,
        "Time":DateTime.now()

      };
      _saveData.addConversationMessges(widget.chatRoomId, MessageMap);
    }


  }

  @override
  void initState() {
    // TODO: implement initState



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(widget.chatRoomId.toString().replaceAll(" ", "").replaceAll(Constants.MyName, "")),
      body: Column(
        children: [
          Expanded(child: Stack(children:[chatMessageList()])),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey,
              ),


              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _messagecontroller,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            hintStyle: TextStyle(color: Colors.white),
                            hintText: "Type message..."),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                        sendMessage();
                        _messagecontroller.clear();

                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF6C6868),
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 40,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )

    );
  }
}
class MessageTile extends StatelessWidget {
  final String Message;
  final bool IsSendbyMe;
  MessageTile(this.Message,this.IsSendbyMe);
  

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: IsSendbyMe?0:24,right: IsSendbyMe?24:0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: IsSendbyMe?Alignment.centerRight:Alignment.centerLeft,
      child: Container(

        padding: EdgeInsets.symmetric(vertical: 16,horizontal: 24),
        decoration: BoxDecoration(
          borderRadius:IsSendbyMe?BorderRadius.only(
        topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomLeft: Radius.circular(23)):
        BorderRadius.only(
        topLeft: Radius.circular(23),
    topRight: Radius.circular(23),
    bottomRight: Radius.circular(23)),
          color: IsSendbyMe?Colors.blue:Colors.black45
        ),



        child: Text(Message,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
