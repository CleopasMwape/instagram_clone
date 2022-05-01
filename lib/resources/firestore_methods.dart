import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/postModel.dart';
import 'package:instagram_clone/models/userModel.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:instagram_clone/resources/user_auth_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost({
    required Uint8List file,
    required String description,
  }) async {
    String res = "";
    try {
      String imageUrl = await StorageMethods()
          .saveimage(child: 'posts', file: file, isPost: true);
      UserModel user = await AuthMethods().getUserDetails();
      String postId = user.uid + const Uuid().v1();

      PostModel post = PostModel(
          description: description,
          uid: user.uid,
          username: user.username,
          postId: postId,
          datePublished: DateTime.now(),
          photoUrl: imageUrl,
          profilePic: user.profilePic,
          likes: []);

      _firestore.collection('posts').doc(post.postId).set(post.postToDB());
      res = 'Success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<String> postComment(String postId, String commentText, String uid,
      String profilePic, String username) async {
    String res;
    try {
      if (commentText.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'username': username,
          'commentText': commentText,
          'uid': uid,
          'profilePic': profilePic,
          'datePublished': DateTime.now(),
        });
        res = 'Success';
      } else {
        res = 'Some error occured';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
