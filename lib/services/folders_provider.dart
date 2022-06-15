import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:phytomedicine_app/models/folder_model.dart';

class FolderProvider {
  final CollectionReference foldersCollection =
      FirebaseFirestore.instance.collection('folders');

  final List<FolderModel> folders = [];
  bool isDone = false;

  bool isAdd = false;

  Future getFolders(String uid) async {
    try {
      final querySnapshot =
          await foldersCollection.doc(uid).collection('folders').get();

      for (var doc in querySnapshot.docs) {
        var document = doc.data();
        document['uid'] = doc.id;
        folders.add(FolderModel.fromMap(document));
      }

      return folders;
    } catch (e) {
      return null;
    }
  }

  Future addFolders(FolderModel folder, String uid) async {
    try {
      final documentReference = await foldersCollection
          .doc(uid)
          .collection('folders')
          .add(folder.toMap());

      folder.uid = documentReference.id;

      isAdd = true;

      return folder;
    } catch (e) {
      return null;
    }
  }

  Future editFolders(FolderModel folder, String uid) async {
    try {
      await foldersCollection
          .doc(uid)
          .collection('folders')
          .doc(folder.uid)
          .update(folder.toMap());
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  Future deleteFolders(String folderId, String uid) async {
    try {
      await foldersCollection
          .doc(uid)
          .collection('folders')
          .doc(folderId)
          .delete();

      return true;
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  Future<String?> uploadFile(ImageSource? imageSource, String uid) async {
    if (imageSource != null) {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      if (pickedFile != null) {
        String filename = basename(pickedFile.path);

        Reference ref = FirebaseStorage.instance
            .ref()
            .child("phytomedicine/")
            .child(uid)
            .child(filename);

        await ref.putData(await pickedFile.readAsBytes());

        var dwonloadurl = await ref.getDownloadURL();

        return dwonloadurl;
      }
    }
    return null;
  }
}
