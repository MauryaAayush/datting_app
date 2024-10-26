import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class BlockController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthController authController = Get.find<AuthController>();

  // Block a user
  Future<void> blockUser(String blockedUserId) async {
    String currentUserId = authController.firebaseUser.value?.uid ?? '';

    try {
      await _firestore.collection('blockedUsers').add({
        'blockedBy': currentUserId,
        'blockedUserId': blockedUserId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'User blocked');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Report a user
  Future<void> reportUser(String reportedUserId, String reason) async {
    String currentUserId = authController.firebaseUser.value?.uid ?? '';

    try {
      await _firestore.collection('reportedUsers').add({
        'reportedBy': currentUserId,
        'reportedUserId': reportedUserId,
        'reason': reason,
        'createdAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'User reported');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
