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

  });

  int? id;
  String? action;


  factory Historique.fromJson(Map<String, dynamic> json) => Historique(
    id: json["id"],
    action: json["action"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "action": action,
  };
}
