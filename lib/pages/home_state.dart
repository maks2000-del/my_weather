import 'package:my_weather/models/lacation_model.dart';
import 'package:my_weather/models/weather_entity.dart';

class HomeState {
  final String title;
  final bool europeTemperature;
  final bool isDataLoaded;
  final Location? location;
  final Weather? weather;

  HomeState({
    required this.title,
    required this.europeTemperature,
    required this.isDataLoaded,
    this.location,
    this.weather,
  });

  HomeState copyWith({
    String? title,
    bool? europeTemperature,
    bool? isDataLoaded,
    Location? location,
    Weather? weather,
  }) {
    return HomeState(
      title: title ?? this.title,
      europeTemperature: europeTemperature ?? this.europeTemperature,
      isDataLoaded: isDataLoaded ?? this.isDataLoaded,
      location: location ?? this.location,
      weather: weather ?? this.weather,
    );
  }
}
