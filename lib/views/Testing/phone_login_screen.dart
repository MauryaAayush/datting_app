import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // Import this for input formatters
import '../../controller/auth_controller.dart';

class PhoneLoginScreen extends StatelessWidget {
  final phoneController = TextEditingController(text: '+91 '); // Default value
  final AuthController authController = Get.find<AuthController>();

  PhoneLoginScreen({super.key});

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login with OTP")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String phoneNumber = phoneController.text.trim();

                // Check if the phone number starts with +91
                if (!phoneNumber.startsWith('+91 ') || phoneNumber.length != 13) {
                  showSnackBar(context, 'Please enter a valid phone number in the format +91 XXXXXXXXXX');
                  return; // Exit if the format is invalid
                }

                // Remove the country code before sending the OTP
                String formattedNumber = phoneNumber.replaceFirst('+91 ', '');
                await authController.sendOtp(formattedNumber);
                showSnackBar(context, 'OTP sent successfully! Check your messages.');
              },
              child: Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
