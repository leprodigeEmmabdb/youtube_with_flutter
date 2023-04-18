// To parse this JSON data, do
//
//     final youtube = youtubeFromJson(jsonString);

import 'dart:convert';

Youtube youtubeFromJson(String str) => Youtube.fromJson(json.decode(str));

String youtubeToJson(Youtube data) => json.encode(data.toJson());

class Youtube {
  Youtube({
    required this.id,
    required this.title,
    required this.content,
    required this.video,
  });

  int? id;
  String? title;
  String? content;
  String? video;

  factory Youtube.fromJson(Map<String, dynamic> json) => Youtube(
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
