import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phytomedicine_app/models/condition_model.dart';
import 'package:phytomedicine_app/services/fire_storage_service.dart';

class Conditions {
  final CollectionReference conditionsCollection =
      FirebaseFirestore.instance.collection('conditions');

  DocumentSnapshot? _lastDocument;

  bool isDone = false;
  final List<Condition> conditions = [];

  Future getConditions(String condition) async {
    try {
      QuerySnapshot<Object?> querySnapshot;

      if (_lastDocument != null) {
        if (condition == '') {
          querySnapshot = await conditionsCollection
              .orderBy('title')
              .startAfterDocument(_lastDocument!)
              .limit(7)
              .get();
        } else {
          querySnapshot = await conditionsCollection
              .where('title', isGreaterThanOrEqualTo: condition.capitalize())
              .where('title', isLessThan: condition.capitalize() + 'z')
              .orderBy('title')
              .startAfterDocument(_lastDocument!)
              .limit(7)
              .get();
        }
      } else {
        if (condition == '') {
          querySnapshot =
              await conditionsCollection.orderBy('title').limit(7).get();
        } else {
          querySnapshot = await conditionsCollection
              .where('title', isGreaterThanOrEqualTo: condition.capitalize())
              .where('title', isLessThan: condition.capitalize() + 'z')
              .orderBy('title')
              .limit(7)
              .get();
        }
      }

      for (var doc in querySnapshot.docs) {
        dynamic document = doc.data();

        String? imageName;

        if (document['image'] != null) {
          imageName = await FireStorageService.loadImage(
              '${document['image']}', '/conditions');
        }

        document['image'] = imageName;
        if (conditions
            .where((element) => element.title == document['title'])
            .isEmpty) {
          try {
            conditions.add(Condition.fromJson(document));
          } catch (e) {
            continue;
          }
        }
      }

      _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

      return 1;
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
