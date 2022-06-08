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
        latitude: json['lat'],
        longitude: json['lon'],
        country: json['country'],
      );
}
