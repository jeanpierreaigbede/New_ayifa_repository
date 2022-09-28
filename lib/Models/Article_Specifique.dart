// To parse this JSON data, do
//
//     final articleSpecifique = articleSpecifiqueFromJson(jsonString);

import 'dart:convert';

ArticleSpecifique articleSpecifiqueFromJson(String str) => ArticleSpecifique.fromJson(json.decode(str));

String articleSpecifiqueToJson(ArticleSpecifique data) => json.encode(data.toJson());

class ArticleSpecifique {
  ArticleSpecifique({
    required this.id,
    required this.titre,
   required  this.contenu,
   required  this.userId,
   required this.createdAt,
   required  this.updatedAt,
    this.deletedAt,
  });

  int id;
  String titre;
  String contenu;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory ArticleSpecifique.fromJson(Map<String, dynamic> json) => ArticleSpecifique(
    id: json["id"],
    titre: json["titre"],
    contenu: json["contenu"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "titre": titre,
    "contenu": contenu,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
