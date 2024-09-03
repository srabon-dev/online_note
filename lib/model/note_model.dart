import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  final Timestamp? createdAt;
  final String? desc;
  final String? title;

  NoteModel({
    this.createdAt,
    this.desc,
    this.title,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    createdAt: json["createdAt"],
    desc: json["desc"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "desc": desc,
    "title": title,
  };
}
