import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../views/Testing/otp_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Rxn<User> firebaseUser = Rxn<User>();
  String verificationId = "";

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // Register a new user with additional fields
  Future<void> register(String name, String email, String mobile, String password) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Store additional user info in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'mobile': mobile,
        'uid': userCredential.user!.uid,
      });

      Get.snackbar('Success', 'Account created');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Login user
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Logged in');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Send OTP to the phone number
  Future<void> sendOtp(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve code; automatically signs in if OTP is detected
        await _auth.signInWithCredential(credential);
        Get.snackbar('Success', 'Logged in automatically');
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar('Error', e.message ?? 'Verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        Get.snackbar('OTP Sent', 'Check your phone for the OTP');
        Get.to(() => OtpScreen()); // Navigate to OTP screen
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
      timeout: Duration(seconds: 60),
    );
  }

  // Verify OTP entered by the user
  Future<void> verifyOtp(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      Get.snackbar('Success', 'Logged in');
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP');
    }
  }

}
