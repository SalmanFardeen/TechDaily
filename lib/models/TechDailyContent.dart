// To parse this JSON data, do
//
//     final techDailyApi = techDailyApiFromJson(jsonString);

import 'dart:convert';

List<TechDailyContent> techDailyApiFromJson(String str) => List<TechDailyContent>.from(
    json.decode(str).map((x) => TechDailyContent.fromJson(x)));

String techDailyApiToJson(List<TechDailyContent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TechDailyContent {
  TechDailyContent({
    this.id,
    this.url,
    this.title,
    this.author,
    this.pubDate,
    this.imgUrl,
    this.createdAt,
    this.updatedAt,
    this.owner_id,
  });

  int id;
  String url;
  String title;
  String author;
  DateTime pubDate;
  String imgUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int owner_id;

  factory TechDailyContent.fromJson(Map<String, dynamic> json) => TechDailyContent(
        id: json["id"],
        url: json["url"],
        title: json["title"],
        author: json["author"] == null ? null : json["author"],
        pubDate: json["pub_date"] == null ? null : DateTime.tryParse(json["pub_date"]),
        imgUrl: json["img_url"],
        createdAt: DateTime.tryParse(json["created_at"]),
        updatedAt: DateTime.tryParse(json["updated_at"]),
        owner_id: json["owner_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "title": title,
        "author": author == null ? null : author,
        "pub_date": pubDate == null ? null : pubDate,
        "img_url": imgUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "owner_id": owner_id,
      };
}
