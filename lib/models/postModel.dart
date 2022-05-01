import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String photoUrl;
  final String profilePic;
  final likes;

  PostModel(
      {required this.description,
      required this.uid,
      required this.username,
      required this.postId,
      required this.datePublished,
      required this.photoUrl,
      required this.profilePic,
      required this.likes});

  Map<String, dynamic> postToDB() {
    return {
      'username': username,
      'description': description,
      'uid': uid,
      'postId': postId,
      'datePublished': datePublished,
      'photoUrl': photoUrl,
      'profilePicture': profilePic,
      'likes': likes
    };
  }

  static PostModel userFromDB(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return PostModel(
        username: snapshot['username'],
        description: snapshot['description'],
        uid: snapshot['uid'],
        datePublished: snapshot['datePublished'],
        photoUrl: snapshot['photoUrl'],
        likes: snapshot['likes'],
        profilePic: snapshot['profilePicture'],
        postId: snapshot['postId']);
  }
}
