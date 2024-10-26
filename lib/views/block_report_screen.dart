import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/block_controller.dart';


class BlockReportScreen extends StatelessWidget {
  final String userId;
  final BlockController blockController = Get.find<BlockController>();

  BlockReportScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Block/Report User")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              blockController.blockUser(userId);
            },
            child: Text('Block User'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text("Report User"),
                  content: TextField(
                    decoration: InputDecoration(hintText: "Reason for reporting"),
                    onSubmitted: (reason) {
                      blockController.reportUser(userId, reason);
                      Get.back();
                    },
                  ),
                ),
              );
            },
            child: Text('Report User'),
          ),
        ],
      ),
    );
  }
}
