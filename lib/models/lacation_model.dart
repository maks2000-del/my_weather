class Location {
  final String cityName;
  final double? latitude;
  final double? longitude;

  Location({
    required this.cityName,
    this.latitude,
    this.longitude,
  });

  Location copyWith({
    String? cityName,
    double? latitude,
    double? longitude,
  }) {
    return Location(
      cityName: cityName ?? this.cityName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        cityName: json['name'],
        latitude: json['lat'],
        longitude: json['lon'],
      );
}
