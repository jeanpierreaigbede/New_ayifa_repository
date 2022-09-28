// To parse this JSON data, do
//
//     final media = mediaFromJson(jsonString);

import 'dart:convert';

List<Media> mediaFromJson(String str) => List<Media>.from(json.decode(str).map((x) => Media.fromJson(x)));

String mediaToJson(List<Media> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Media {
  Media({
   required this.id,
    required this.articleId,
    required this.path,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  int id;
  int articleId;
  String path;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    articleId: json["article_id"],
    path: json["path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "article_id": articleId,
    "path": path,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
