class Location {
  final String cityName;
  final String country;
  final double? latitude;
  final double? longitude;

  Location({
    required this.cityName,
    required this.country,
    this.latitude,
    this.longitude,
  });

  Location copyWith({
    String? cityName,
    String? country,
    double? latitude,
    double? longitude,
  }) {
    return Location(
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        cityName: json['name'],
        latitude: double.parse(json['lat'].toString()),
        longitude: double.parse(json['lon'].toString()),
        country: json['country'],
      );

  Map<String, String> toMap(Location location) {
    return {
      'name': location.cityName,
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString(),
      'country': location.country,
    };
  }
}
