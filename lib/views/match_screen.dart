import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/like_controller.dart';

class MatchScreen extends StatelessWidget {
  final LikeController likeController = Get.find<LikeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Find Matches")),
      body: StreamBuilder(
        stream: likeController.fetchPotentialMatches(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['profilePicture']),
                    ),
                    title: Text(user['name']),
                    subtitle: Text(user['bio']),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        likeController.likeUser(user.id);
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
