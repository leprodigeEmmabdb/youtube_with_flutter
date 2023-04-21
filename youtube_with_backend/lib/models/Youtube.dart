// To parse this JSON data, do
//
//     final youtube = youtubeFromJson(jsonString);

import 'dart:convert';

YoutubeModele youtubeFromJson(String str) => YoutubeModele.fromJson(json.decode(str));

String youtubeToJson(YoutubeModele data) => json.encode(data.toJson());

class YoutubeModele {
  YoutubeModele({
    required this.id,
    required this.title,
    required this.content,
    required this.video,
  });

  int? id;
  String? title;
  String? content;
  String? video;

  factory YoutubeModele.fromJson(Map<String, dynamic> json) => YoutubeModele(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "video": video,
  };
}
