import 'package:appdev/screen/auth_serivces.dart';
import 'package:appdev/screen/chat_bubble.dart';
import 'package:appdev/screen/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController message = TextEditingController();
  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void sendMessage() async {
    if (message.text.isNotEmpty) {
      await chatService.sendMessage(receiverID, message.text);
      message.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessage(),
          ),
          buildUserInput()
        ],
      ),
    );
  }

  Widget buildMessage() {
    String senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: chatService.getMessage(receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(
              message: data["message"],
              isCurrentUser: isCurrentUser,
            )
          ],
        ));
  }

  Widget buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: message,
              obscureText: false,
              decoration: InputDecoration(
                  labelText: "Type your message",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            shape: BoxShape.circle,
          ),
          margin: EdgeInsets.only(right: 25),
          child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
