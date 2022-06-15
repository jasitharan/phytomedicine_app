import 'package:cloud_firestore/cloud_firestore.dart';
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
}
