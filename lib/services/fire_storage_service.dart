import 'package:firebase_storage/firebase_storage.dart';

class FireStorageService {
  FireStorageService();
  static Future<dynamic> loadImage(String image, String path) async {
    return await FirebaseStorage.instance
        .ref(path)
        .child(image)
        .getDownloadURL();
  }
}
