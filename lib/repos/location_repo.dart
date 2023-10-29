import 'dart:convert';

import 'package:http/http.dart';

import '../models/location.dart';

class LocationRepository {
  String baseurl = "https://api.bigdatacloud.net/data/reverse-geocode-client";

  Future<Location> getLocation(latitude, longitude) async {
    String endpoint =
        "?latitude=$latitude&longitude=$longitude&localityLanguage=en";
    Response response = await get(Uri.parse(baseurl + endpoint));
    if (response.statusCode == 200) {
      return Location.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
