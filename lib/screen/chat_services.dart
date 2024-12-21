import 'package:appdev/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService {
  // 1. get instance of Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  // 2. get user stream

  // <List<Map<Stream, dynamic>>
  //  meaning of the line is that how data is show on firebase cloud
  //  like:
  //    [
  //      {
  //      'email': 'shaharyarali209@gmail.com'
  //      'id': -----
  //       },
  //       {
  //      'email': 'shaharyarali209@gmail.com'
  //      'id': -----
  //       },
  //     ];
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

// 3. send message
  Future<void> sendMessage(String receiverID, message) async {
    // get current user info
    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        message: message,
        receiverID: receiverID,
        timestamp: timestamp);

    // construct chat room ID for the two user (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');
    // add new message to database
    await firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("message")
        .add(newMessage.toMap());
  }

// 4. get message
  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return firestore
        .collection("chat_room")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
