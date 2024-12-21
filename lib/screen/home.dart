import 'package:appdev/screen/auth_serivces.dart';
import 'package:appdev/screen/chat_page.dart';
import 'package:appdev/screen/chat_services.dart';
import 'package:appdev/screen/login.dart';
import 'package:appdev/screen/user_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  // chat & auth services
  final ChatService chatService = ChatService();
  final AuthService authSerivce = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Home"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: buildUserList(),
    );
  }

  buildUserList() {
    return StreamBuilder(
        stream: chatService.getUserStream(),
        builder: (context, snapshot) {
          // error handing
          if (snapshot.hasError) {
            return Center(child: const RefreshProgressIndicator());
          }
          // loading data..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          // return List view
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => buildUserListItem(userData, context)).toList(),
          );
        });
  }

  Widget buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if(userData["email"] != authSerivce.getCurrentUser()!.email){
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverEmail: userData["email"],
                    receiverID : userData["uid"],
                  )));
        },
      );
    }else{
      return Container();
    }
  }

}
