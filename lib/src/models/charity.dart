// To parse this JSON data, do
//
//     final charity = charityFromJson(jsonString);

import 'dart:convert';

List<Charity> charityFromJson(String str) => List<Charity>.from(json.decode(str).map((x) => Charity.fromJson(x)));

String charityToJson(List<Charity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Charity {
  Charity({
    this.id,
    this.title,
  });

  int id;
  String title;

  factory Charity.fromJson(Map<String, dynamic> json) => Charity(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
