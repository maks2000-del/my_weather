import 'package:my_weather/helpers/internet_connection.dart';
import 'package:my_weather/models/lacation_model.dart';
import 'package:my_weather/models/weather_model.dart';
import 'package:my_weather/repositories/location_repository_cache.dart';
import 'package:my_weather/repositories/location_repository_http.dart';
import 'package:my_weather/repositories/weather_repository_cache.dart';
import 'package:my_weather/repositories/weather_repository_http.dart';

class HomeState {
  final String title;
  final bool europeTemperature;
  final bool isDataLoaded;
  final bool isInformationUpToDate;
  final double temperatureStep;
  final Map<String, String> appDictionary;

  final InternetConnection internetConnection;
  final LocationHttpRepositoryImpl locationHttpRepositoryImpl;
  final WeatherHttpPerositoryImpl weatherHttpPerositoryImpl;
  final LocationLocalDataSourceImpl locationLocalDataSourceImpl;
  final WeatherLocalDataSourceImpl weatherLocalDataSourceImpl;

  final Location? location;
  final Weather? weather;

  HomeState({
    required this.title,
    required this.europeTemperature,
    required this.isDataLoaded,
    required this.isInformationUpToDate,
    required this.temperatureStep,
    required this.appDictionary,
    required this.internetConnection,
    required this.locationHttpRepositoryImpl,
    required this.weatherHttpPerositoryImpl,
    required this.locationLocalDataSourceImpl,
    required this.weatherLocalDataSourceImpl,
    this.location,
    this.weather,
  });

  HomeState copyWith({
    String? title,
    bool? europeTemperature,
    bool? isDataLoaded,
    bool? isInformationUpToDate,
    double? temperatureStep,
    Map<String, String>? appDictionary,
    InternetConnection? internetConnection,
    LocationHttpRepositoryImpl? locationHttpRepositoryImpl,
    WeatherHttpPerositoryImpl? weatherHttpPerositoryImpl,
    LocationLocalDataSourceImpl? locationLocalDataSourceImpl,
    WeatherLocalDataSourceImpl? weatherLocalDataSourceImpl,
    Location? location,
    Weather? weather,
  }) {
    return HomeState(
      title: title ?? this.title,
      europeTemperature: europeTemperature ?? this.europeTemperature,
      isDataLoaded: isDataLoaded ?? this.isDataLoaded,
      isInformationUpToDate:
          isInformationUpToDate ?? this.isInformationUpToDate,
      temperatureStep: temperatureStep ?? this.temperatureStep,
      appDictionary: appDictionary ?? this.appDictionary,
      internetConnection: internetConnection ?? this.internetConnection,
      locationHttpRepositoryImpl:
          locationHttpRepositoryImpl ?? this.locationHttpRepositoryImpl,
      weatherHttpPerositoryImpl:
          weatherHttpPerositoryImpl ?? this.weatherHttpPerositoryImpl,
      locationLocalDataSourceImpl:
          locationLocalDataSourceImpl ?? this.locationLocalDataSourceImpl,
      weatherLocalDataSourceImpl:
          weatherLocalDataSourceImpl ?? this.weatherLocalDataSourceImpl,
      location: location ?? this.location,
      weather: weather ?? this.weather,
    );
  }
}
