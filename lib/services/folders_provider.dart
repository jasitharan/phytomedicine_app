import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phytomedicine_app/models/folder_model.dart';

class FolderProvider {
  final CollectionReference foldersCollection =
      FirebaseFirestore.instance.collection('folders');

  final List<FolderModel> folders = [];
  bool isDone = false;

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

  Future addFolders(String folder, String uid) async {
    try {
      final querySnapshot = await foldersCollection
          .doc(uid)
          .collection('folders')
          .orderBy('createdAt')
          .get();

      for (var doc in querySnapshot.docs) {
        print(doc);
      }

      return folders;
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  Future editFolders(String folder, String uid) async {
    try {
      final querySnapshot = await foldersCollection
          .doc(uid)
          .collection('folders')
          .orderBy('createdAt')
          .get();

      for (var doc in querySnapshot.docs) {
        print(doc);
      }

      return folders;
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  Future deleteFolders(String folder, String uid) async {
    try {
      final querySnapshot = await foldersCollection
          .doc(uid)
          .collection('folders')
          .orderBy('createdAt')
          .get();

      for (var doc in querySnapshot.docs) {
        print(doc);
      }

      return folders;
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }
}
