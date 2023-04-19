// To parse this JSON data, do
//
//     final historique = historiqueFromJson(jsonString);

import 'dart:convert';

Historique historiqueFromJson(String str) => Historique.fromJson(json.decode(str));

String historiqueToJson(Historique data) => json.encode(data.toJson());

class Historique {
  Historique({
    required this.id,
    required this.action,
    required this.createdAt,
  });

  int id;
  String action;
  DateTime createdAt;

  factory Historique.fromJson(Map<String, dynamic> json) => Historique(
    id: json["id"],
    action: json["action"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "action": action,
    "created_at": createdAt.toIso8601String(),
  };
}
