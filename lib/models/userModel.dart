import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String uid;
  final String bio;
  final List followers;
  final List following;
  final String profilePic;

  UserModel(
      {required this.username,
      required this.email,
      required this.uid,
      required this.bio,
      required this.followers,
      required this.following,
      required this.profilePic});

  Map<String, dynamic> userToDB() {
    return {
      'username': username,
      'email': email,
      'uid': uid,
      'bio': bio,
      'followers': followers,
      'following': following,
      'profilePicture': profilePic,
    };
  }

  static UserModel userFromDB(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        username: snapshot['username'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        bio: snapshot['bio'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        profilePic: snapshot['profilePicture']);
  }
}
