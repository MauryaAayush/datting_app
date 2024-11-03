// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../model/user_model.dart';
// import 'auth_controller.dart';
//
// class UserController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   AuthController authController = Get.find<AuthController>();
//
//   // Add user profile to Firestore
//   Future<void> createUserProfile(UserModel user) async {
//     try {
//       await _firestore.collection('users').doc(authController.firebaseUser.value?.uid).set(user.toMap());
//       Get.snackbar('Success', 'Profile created');
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     }
//   }
//
//   // Fetch user data from Firestore
//   Stream<UserModel> getUserProfile() {
//     return _firestore
//         .collection('users')
//         .doc(authController.firebaseUser.value?.uid)
//         .snapshots()
//         .map((snapshot) => UserModel.fromDocumentSnapshot(snapshot));
//   }
// }
