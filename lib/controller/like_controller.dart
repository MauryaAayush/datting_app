import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class LikeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthController authController = Get.find<AuthController>();

  // Like a user
  Future<void> likeUser(String likedUserId) async {
    String currentUserId = authController.firebaseUser.value?.uid ?? '';

    try {
      await _firestore.collection('likes').doc(currentUserId).set({
        'likedUserId': likedUserId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Check if the liked user has also liked the current user
      DocumentSnapshot likedUserLikes = await _firestore.collection('likes').doc(likedUserId).get();
      if (likedUserLikes.exists) {
        String userWhoLikedBack = likedUserLikes['likedUserId'];
        if (userWhoLikedBack == currentUserId) {
          // Create a match
          await _firestore.collection('matches').add({
            'user1Id': currentUserId,
            'user2Id': likedUserId,
            'matchedAt': FieldValue.serverTimestamp(),
          });
          Get.snackbar('Match!', 'You have a new match with $likedUserId');
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Fetch potential matches
  Stream<QuerySnapshot> fetchPotentialMatches() {
    return _firestore.collection('users').snapshots();
  }
}
