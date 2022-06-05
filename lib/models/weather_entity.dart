import 'package:my_weather/models/info_model.dart';

class Weather {
  final Info currentWeather;
  final List<Info> hourWeahter;
  final List<Info> dayWeather;

  Weather({
    required this.currentWeather,
    required this.hourWeahter,
    required this.dayWeather,
  });

  Weather copyWith({
    Info? currentWeather,
    List<Info>? hourWeahter,
    List<Info>? dayWeather,
  }) {
    return Weather(
      currentWeather: currentWeather ?? this.currentWeather,
      hourWeahter: hourWeahter ?? this.hourWeahter,
      dayWeather: dayWeather ?? this.dayWeather,
    );
  }

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        currentWeather: json['currentWeather'],
        hourWeahter: json['hourWeahter'],
        dayWeather: json['dayWeather'],
      );
}
