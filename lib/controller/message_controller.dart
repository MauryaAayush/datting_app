import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class MessageController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthController authController = Get.find<AuthController>();

  // Send a message
  Future<void> sendMessage(String matchId, String message) async {
    String currentUserId = authController.firebaseUser.value?.uid ?? '';

    try {
      await _firestore.collection('matches').doc(matchId).collection('messages').add({
        'senderId': currentUserId,
        'text': message,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Fetch messages between matched users
  Stream<QuerySnapshot> getMessages(String matchId) {
    return _firestore.collection('matches').doc(matchId).collection('messages').orderBy('createdAt').snapshots();
  }
}
