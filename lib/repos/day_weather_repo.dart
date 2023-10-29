import 'dart:convert';
import 'package:http/http.dart';
import '../models/day_weather.dart';

class DayWeatherRepository {
  String baseurl = "https://api.open-meteo.com/v1/forecast?";

  Future<DayWeather> getDayWeather() async {
    String endpoint =
        "latitude=13.09&longitude=80.28&daily=temperature_2m_max,temperature_2m_min&"
        "timezone=IST&forecast_days=10";

    Response response = await get(Uri.parse(baseurl + endpoint));
    if (response.statusCode == 200) {
      return DayWeather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
