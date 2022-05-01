import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  saveimage(
      {required String child,
      required Uint8List file,
      required bool isPost}) async {
    Reference ref = _storage.ref().child(child).child(_auth.currentUser!.uid);
    if (isPost) {
      ref = ref.child(const Uuid().v1());
    }

    UploadTask _upload = ref.putData(file);
    TaskSnapshot snap = await _upload;
    String imageUrl = await snap.ref.getDownloadURL();
    return imageUrl;
  }
}
