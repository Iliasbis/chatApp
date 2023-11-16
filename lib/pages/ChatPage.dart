
// ignore_for_file: file_names

import 'package:chat_app/component/DefaultSnackBar.dart';
import 'package:chat_app/component/Default_Textfield.dart';
import 'package:chat_app/responsiveText/MediumText.dart';
import 'package:chat_app/responsiveText/SmallText.dart';
import 'package:chat_app/services/firebase_chat/ChatService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiveUserEmail;
  final String receiveUserID;
  const ChatPage(
      {super.key, required this.receiveUserEmail, required this.receiveUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiveUserID,
        _messageController.text,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        backgroundColor: Colors.deepPurple.shade100,
        elevation: 0,
        title: MediumText(
          text: widget.receiveUserEmail,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16),
        child: Column(children: [
          Expanded(child: _buildMessageList(context)),
          _buildMessageInput(),
          const SizedBox(height: 35),
        ]),
      ),
    );
  }

  Widget _buildMessageList(BuildContext context) {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiveUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          DefaultSnackBar.showSnackBarError(context, "Error", Colors.red);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children:
              snapshot.data!.docs.map((d) => _buildMessageItem(d)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    var align = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: align,
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          SmallText(text: data['senderEmail']),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.deepPurple.shade400),
              child: SmallText(
                text: data['message'],
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: DefaultTextfield(
            hintText: "Message",
            controller: _messageController,
            labelText: "message",
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(Icons.send_rounded),
        ),
      ],
    );
  }
}
