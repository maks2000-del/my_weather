import 'package:my_weather/models/lacation_model.dart';
import 'package:my_weather/models/weather_entity.dart';

class HomeState {
  final String title;
  final bool europeTemperature;
  final bool isDataLoaded;
  final bool isInformationUpToDate;
  final Location? location;
  final Weather? weather;

  HomeState({
    required this.title,
    required this.europeTemperature,
    required this.isDataLoaded,
    required this.isInformationUpToDate,
    this.location,
    this.weather,
  });

  HomeState copyWith({
    String? title,
    bool? europeTemperature,
    bool? isDataLoaded,
    bool? isInformationUpToDate,
    Location? location,
    Weather? weather,
  }) {
    return HomeState(
      title: title ?? this.title,
      europeTemperature: europeTemperature ?? this.europeTemperature,
      isDataLoaded: isDataLoaded ?? this.isDataLoaded,
      isInformationUpToDate:
          isInformationUpToDate ?? this.isInformationUpToDate,
      location: location ?? this.location,
      weather: weather ?? this.weather,
    );
  }
}
