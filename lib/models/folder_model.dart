import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FolderModel {
  String? uid;
  String name;
  List<String>? filesUrls;

  FolderModel({this.uid, required this.name, required this.filesUrls});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'filesUrls': filesUrls,
    };
  }

  factory FolderModel.fromMap(Map<String, dynamic> map) {
    return FolderModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      filesUrls: List<String>.from(map['filesUrls']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FolderModel.fromJson(String source) =>
      FolderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
