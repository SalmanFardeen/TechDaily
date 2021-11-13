

import 'dart:convert';

List<TechDailyOwner> techDailyOwnerFromJson(String str) =>
    List<TechDailyOwner>.from(
        json.decode(str).map((x) => TechDailyOwner.fromJson(x)));

String techDailyOwnerToJson(List<TechDailyOwner> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TechDailyOwner {
  TechDailyOwner({
    this.id,
    this.name,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String url;
  DateTime createdAt;
  DateTime updatedAt;

  factory TechDailyOwner.fromJson(Map<String, dynamic> json) => TechDailyOwner(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        createdAt: DateTime.tryParse(json["created_at"]),
        updatedAt: DateTime.tryParse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
