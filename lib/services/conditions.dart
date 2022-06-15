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
    conditions.clear();

    try {
      Query<Object?> query1;
      Query<Object?> query2;

      if (_lastDocument != null) {
        query1 = conditionsCollection
            .orderBy('title')
            .startAfterDocument(_lastDocument!)
            .limit(6);

        query2 = conditionsCollection
            .where('title', isGreaterThanOrEqualTo: condition.capitalize())
            .where('title', isLessThan: condition.capitalize() + 'z')
            .orderBy('title')
            .startAfterDocument(_lastDocument!)
            .limit(6);
      } else {
        query1 = conditionsCollection.orderBy('title').limit(6);
        query2 = conditionsCollection
            .where('title', isGreaterThanOrEqualTo: condition.capitalize())
            .where('title', isLessThan: condition.capitalize() + 'z')
            .orderBy('title')
            .limit(6);
      }

      final querySnapshot =
          condition == '' ? await query1.get() : await query2.get();

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
      return null;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
