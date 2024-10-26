import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/message_controller.dart';

class ChatScreen extends StatelessWidget {
  final String matchId;
  final MessageController messageController = Get.find<MessageController>();
  final messageTextController = TextEditingController();

  ChatScreen({required this.matchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: messageController.getMessages(matchId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var messages = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index];
                      return ListTile(
                        title: Text(message['text']),
                        subtitle: Text(message['senderId']),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    decoration: InputDecoration(labelText: "Enter message"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    messageController.sendMessage(matchId, messageTextController.text);
                    messageTextController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
