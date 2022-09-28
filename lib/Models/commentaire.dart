// To parse this JSON data, do
//
//     final commentaire = commentaireFromJson(jsonString);

import 'dart:convert';

List<Commentaire> commentaireFromJson(String str) => List<Commentaire>.from(json.decode(str).map((x) => Commentaire.fromJson(x)));

String commentaireToJson(List<Commentaire> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Commentaire {
  Commentaire({
    required this.id,
    required this.articleId,
    required this.contenu,
    required  this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  int id;
  int articleId;
  String contenu;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  factory Commentaire.fromJson(Map<String, dynamic> json) => Commentaire(
    id: json["id"],
    articleId: json["article_id"],
    contenu: json["contenu"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "article_id": articleId,
    "contenu": contenu,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt == null ? null : deletedAt!.toIso8601String(),
  };
}
