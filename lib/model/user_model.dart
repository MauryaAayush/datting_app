// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserModel {
//   String userId;
//   String name;
//   String email;
//   String profilePicture;
//   int age;
//   String bio;
//
//   UserModel({required this.userId, required this.name, required this.email, required this.profilePicture, required this.age, required this.bio});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'name': name,
//       'email': email,
//       'profilePicture': profilePicture,
//       'age': age,
//       'bio': bio,
//     };
//   }
//
//   factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
//     return UserModel(
//       userId: doc.id,
//       name: doc['name'],
//       email: doc['email'],
//       profilePicture: doc['profilePicture'],
//       age: doc['age'],
//       bio: doc['bio'],
//     );
//   }
// }
