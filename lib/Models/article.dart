import 'dart:convert';


// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);
List<Article> articleFromJson(String str) => List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

String articleToJson(List<Article> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
  Article({
  required  this.id,
    required   this.titre,
    required   this.contenu,
    required   this.userId,
    required   this.createdAt,
    required     this.updatedAt,
          this.deletedAt,
  });

  int id;
  String titre;
  String contenu;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime ? deletedAt;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json["id"],
    titre: json["titre"],
    contenu: json["contenu"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "titre": titre,
    "contenu": contenu,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt == null ? null : deletedAt.toString(),
  };
}
/*
import 'dart:convert';

Map<String, Article> articleFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Article>(k, Article.fromJson(v)));

String articleToJson(Map<String, Article> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Article {
  Article({
    required this.id,
    required this.titre,
    required this.contenu,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  int id;
  String titre;
  String contenu;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
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

*/

