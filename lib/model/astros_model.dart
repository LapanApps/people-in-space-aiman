import 'dart:convert';

import 'package:http/http.dart' as http;

class Astros {
  Astros({
    required this.name,
    required this.imgUrl,
    required this.craft,
  });

  String name;
  String imgUrl;
  String craft;

  factory Astros.fromJson(Map<String, dynamic> json) => Astros(
        name: json["name"],
        imgUrl: json["contentUrl"],
        craft: json["craft"],
      );
  static Future<List<Astros>> getAstros() async {
    var url = Uri.parse("https://astros.iqfareez.com/data");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json["people"].map<Astros>((e) => Astros.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}


