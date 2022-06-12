import 'package:my_weather/models/info_model.dart';
import 'package:my_weather/models/lacation_model.dart';
import 'package:my_weather/repositories/location_repository_http.dart';
import 'package:my_weather/repositories/weather_repository_http.dart';

class CityWeatherState {
  final bool isDataLoaded;
  final LocationHttpRepositoryImpl locationHttpRepositoryImpl;
  final WeatherHttpPerositoryImpl weatherHttpPerositoryImpl;
  final Location? location;
  final Info? info;

  CityWeatherState({
    required this.isDataLoaded,
    required this.locationHttpRepositoryImpl,
    required this.weatherHttpPerositoryImpl,
    this.location,
    this.info,
  });

  CityWeatherState copyWith({
    bool? europeTemperature,
    bool? isDataLoaded,
    double? temperatureStep,
    LocationHttpRepositoryImpl? locationHttpRepositoryImpl,
    WeatherHttpPerositoryImpl? weatherHttpPerositoryImpl,
    Location? location,
    Info? info,
  }) {
    return CityWeatherState(
      isDataLoaded: isDataLoaded ?? this.isDataLoaded,
      locationHttpRepositoryImpl:
          locationHttpRepositoryImpl ?? this.locationHttpRepositoryImpl,
      weatherHttpPerositoryImpl:
          weatherHttpPerositoryImpl ?? this.weatherHttpPerositoryImpl,
      location: location ?? this.location,
      info: info ?? this.info,
    );
  }
}
