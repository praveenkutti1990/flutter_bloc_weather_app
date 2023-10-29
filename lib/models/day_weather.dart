class DayWeather {
  double? latitude;
  double? longitude;
  double? elevation;
  DailyUnits? dailyUnits;
  Daily? daily;

  DayWeather(
      {this.latitude,
      this.longitude,
      this.elevation,
      this.dailyUnits,
      this.daily});

  DayWeather.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    elevation = json['elevation'];
    dailyUnits = json['daily_units'] != null
        ? DailyUnits.fromJson(json['daily_units'])
        : null;
    daily = json['daily'] != null ? Daily.fromJson(json['daily']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['elevation'] = elevation;
    if (dailyUnits != null) {
      data['daily_units'] = dailyUnits!.toJson();
    }
    if (daily != null) {
      data['daily'] = daily!.toJson();
    }
    return data;
  }
}

class DailyUnits {
  String? time;
  String? temperature2mMax;
  String? temperature2mMin;

  DailyUnits({this.time, this.temperature2mMax, this.temperature2mMin});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    temperature2mMax = json['temperature_2m_max'];
    temperature2mMin = json['temperature_2m_min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temperature_2m_max'] = temperature2mMax;
    data['temperature_2m_min'] = temperature2mMin;
    return data;
  }
}

class Daily {
  List<String>? time;
  List<double>? temperature2mMax;
  List<double>? temperature2mMin;

  Daily({this.time, this.temperature2mMax, this.temperature2mMin});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    temperature2mMax = json['temperature_2m_max'].cast<double>();
    temperature2mMin = json['temperature_2m_min'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['temperature_2m_max'] = temperature2mMax;
    data['temperature_2m_min'] = temperature2mMin;
    return data;
  }
}
