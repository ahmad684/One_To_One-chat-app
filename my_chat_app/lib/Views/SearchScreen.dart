import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/Views/CoverstionScreen.dart';
import 'package:my_chat_app/authentication1/Constants.dart';
import 'package:my_chat_app/authentication1/UserInfo.dart';
import 'package:my_chat_app/widget/apBar.dart';

var db = FirebaseFirestore.instance;
bool isLoading = false;
SaveData _saveData = new SaveData();

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = new TextEditingController();
  var searchsnapshot;
  InitisatSearch() {
    _saveData.getUser(_searchController.text.toUpperCase()).then((val) {
      setState(() {
        searchsnapshot = val;
      });
    });
  }
  StartConversation(String username){
    print(username);
    print(Constants.MyName);

    if(username!=Constants.MyName.toUpperCase()){
    String chatRoomID=GetChatRoomID(username, Constants.MyName);
    List<String> user=[username,Constants.MyName];
    Map<String,dynamic> ChatRoomMAp={
      "Users":user,
      "chatRoomID":chatRoomID
    };
    _saveData.CreatChatRoom(chatRoomID, ChatRoomMAp);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Conversation(chatRoomID)));
  }else{
    _showMyDialog("Alert!", "You cannot send Message to yourself", "ok");
  }

  }
Widget SearchTile({String? uname,String? uemail}){
    return
      Container(
          decoration: BoxDecoration(

            // border: Border(
            //   bottom: BorderSide(width: 2,color: Colors.white54)
            // )

          ),
          child: Column(
            children: [
              ListTile(

                title: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    uname!,
                    style: TextStyle(color: Colors.white,
                        fontSize: 25
                    ),
                  ),
                ),
                subtitle: Text("  "+
                    uemail!,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  iconSize: 50,
                  color: Color(0xff145c9E),
                  onPressed: (){
                    StartConversation(uname);
                  },
                  icon: Icon(Icons.message),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16,0,16,0),
                child: Divider(
                  thickness: 2,
                  color: Colors.white54,

                ),
              )
            ],
          ));
}
  Widget SeaechList() {
    if(searchsnapshot==null) return CircularProgressIndicator();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: searchsnapshot.docs.length,
        itemBuilder: (context, index) {


          return  SearchTile(
              uname: searchsnapshot.docs[index]["Name"],
              uemail: searchsnapshot.docs[index]["Email"]);
        });
  }


  @override
  void initState() {
    // TODO: implement initState
    InitisatSearch();
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain("Search User Here"),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _searchController,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: "Search Here"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        InitisatSearch();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF6C6868),
                              borderRadius: BorderRadius.circular(40)),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 50,
                          )),
                    )
                  ],
                ),
              ),
            ),
            // ignore: unnecessary_null_comparison
            SeaechList(),

          ],
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
}



GetChatRoomID(String a,String b){
  if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return "$b\ $a";
  }
  else{
    return "$a \ $b";
  }

}