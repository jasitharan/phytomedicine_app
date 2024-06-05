import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phytomedicine_app/models/condition_model.dart';
import 'package:phytomedicine_app/services/fire_storage_service.dart';

class Conditions {
  final CollectionReference conditionsCollection =
      FirebaseFirestore.instance.collection('conditions');

  DocumentSnapshot? _lastDocumentForHerbs;
  DocumentSnapshot? _lastDocumentForConditions;

  bool isSearch = false;
  final List<Condition> conditions = [];
  final List<Condition> herbs = [];

  Future getConditions(String condition, bool isHerb) async {
    try {
      DocumentSnapshot? _lastDocument =
          isHerb ? _lastDocumentForHerbs : _lastDocumentForConditions;
      QuerySnapshot<Object?> querySnapshot;
      isSearch = false;

      if (_lastDocument != null) {
        if (condition == '') {
          querySnapshot = await conditionsCollection
              .where('isHerb', isEqualTo: isHerb)
              .orderBy('title')
              .startAfterDocument(_lastDocument)
              .limit(7)
              .get();
        } else {
          _lastDocument = null;
          if (isHerb) {
            herbs.clear();
          } else {
            conditions.clear();
          }
          isSearch = true;
          querySnapshot = await conditionsCollection
              .where('isHerb', isEqualTo: isHerb)
              .where('title', isGreaterThanOrEqualTo: condition.capitalize())
              .where('title', isLessThan: condition.capitalize() + 'z')
              .orderBy('title')
              //.startAfterDocument(_lastDocument!)
              .limit(7)
              .get();
        }
      } else {
        if (condition == '') {
          if (isHerb) {
            herbs.clear();
          } else {
            conditions.clear();
          }
          querySnapshot = await conditionsCollection
              .where('isHerb', isEqualTo: isHerb)
              .orderBy('title')
              .limit(7)
              .get();
        } else {
          _lastDocument = null;
          if (isHerb) {
            herbs.clear();
          } else {
            conditions.clear();
          }
          isSearch = true;
          querySnapshot = await conditionsCollection
              .where('isHerb', isEqualTo: isHerb)
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
        if (isHerb) {
          if (herbs
              .where((element) => element.title == document['title'])
              .isEmpty) {
            try {
              herbs.add(Condition.fromJson(document));
            } catch (e) {
              continue;
            }
          }
        } else {
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
      }

      if (!isSearch) {
        _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      }

      if (isHerb) {
        _lastDocumentForHerbs = _lastDocument;
      } else {
        _lastDocumentForConditions = _lastDocument;
      }

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
