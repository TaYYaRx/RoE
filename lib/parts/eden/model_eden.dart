import 'dart:convert';

import 'package:flutter/material.dart';

List<ModelRoc> modelRocFromJson(String str) =>
    List<ModelRoc>.from(json.decode(str).map((x) => ModelRoc.fromJson(x)));

String modelRocToJson(List<ModelRoc> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelRoc {

  ModelRoc({
    @required this.id,
    @required this.sector,
    @required this.name,
    @required this.bcmaterials,
    @required this.levels,
    @required this.isDone,
  });

  final int id;
  final int sector;
  final String name;
  final String bcmaterials;
  final String levels;
  final int isDone;

  factory ModelRoc.fromJson(Map<String, dynamic> json) => ModelRoc(
        id: json["id"],
        sector: json["sector"],
        name: json["name"],
        bcmaterials: json["bcmaterials"],
        levels: json["levels"],
        isDone: json["isDone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sector": sector,
        "name": name,
        "bcmaterials": bcmaterials,
        "levels": levels,
        "isDone": isDone,
  };
}
