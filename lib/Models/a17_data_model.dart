

import 'dart:convert';

List<DataModel> dataModelFromJson(String str) => List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

String dataModelToJson(List<DataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataModel {
  String country;
  String name;
  String? stateProvince;
  List<String> webPages;

  DataModel({
    required this.country,
    required this.name,
    this.stateProvince,
    required this.webPages,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    country: json["country"],
    name: json["name"],
    stateProvince: json["state-province"],
    webPages: List<String>.from(json["web_pages"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "name": name,
    "state-province": stateProvince,
    "web_pages": List<dynamic>.from(webPages.map((x) => x)),
  };
}
