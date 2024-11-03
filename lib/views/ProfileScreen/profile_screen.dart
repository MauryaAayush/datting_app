// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controller/user_controller.dart';
// import '../../model/user_model.dart';
//
// class ProfileScreen extends StatelessWidget {
//   final nameController = TextEditingController();
//   final ageController = TextEditingController();
//   final bioController = TextEditingController();
//   final UserController userController = Get.find<UserController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
//             TextField(controller: ageController, decoration: InputDecoration(labelText: 'Age')),
//             TextField(controller: bioController, decoration: InputDecoration(labelText: 'Bio')),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 userController.createUserProfile(UserModel(
//                   name: nameController.text,
//                   age: int.parse(ageController.text),
//                   bio: bioController.text, userId: '', email: '', profilePicture: '',
//                 ));
//               },
//               child: const Text('Create Profile'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
