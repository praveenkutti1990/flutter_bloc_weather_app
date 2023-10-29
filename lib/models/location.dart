class Location {
  double? latitude;
  double? longitude;
  String? continent;
  String? city;
  String? country;
  String? state;

  Location(
      {this.latitude,
      this.longitude,
      this.continent,
      this.city,
      this.country,
      this.state});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    continent = json['continent'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['continent'] = continent;
    data['city'] = city;
    data['country'] = country;
    data['state'] = state;
    return data;
  }
}