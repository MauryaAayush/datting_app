import 'package:datting_app/views/AuthenticationScreen/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/auth_controller.dart';
import 'controller/user_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(AuthController());
    Get.put(UserController());
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        home: AuthScreen(),
      )
    );

  }
}
