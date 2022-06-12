import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/helpers/internet_connection.dart';
import 'package:my_weather/injector.dart';
import 'package:my_weather/models/info_model.dart';
import 'package:my_weather/models/weather_model.dart';
import 'package:my_weather/repositories/location_repository_cashe.dart';

import '../repositories/location_repository_http.dart';
import '../repositories/weather_repository_cashe.dart';
import '../repositories/weather_repository_http.dart';
import 'home_state.dart';

import '../helpers/dictionaries.dart' as dictionary;

class HomeCubit extends Cubit<HomeState> {
  final _internetConnection = locator.get<InternetConnection>();

  final _locationPerositoryImpl = locator.get<LocationHttpRerositoryImpl>();
  final _weatherPerositoryImpl = locator.get<WeatherPerositoryImpl>();
  final _localDataSourceImpl = locator.get<LocationLocalDataSourceImpl>();
  final _weatherLocalDataSourceImpl = locator.get<WeatherLocalDataSourceImpl>();

  HomeCubit()
      : super(
          HomeState(
            title: 'up to date',
            europeTemperature: false,
            isDataLoaded: false,
            isInformationUpToDate: false,
            temperatureStep: 0.0,
            weather: Weather(
              currentWeather: Info(
                date: DateTime.now(),
                temperatyre: 0.0,
                iconId: '',
              ),
              hourWeahter: [],
              dayWeather: [],
            ),
            appDictionary: dictionary.engDictionary,
          ),
        );

  void initState() async {
    await _internetConnection.checkForInternetConnection();
    if (_internetConnection.status) {
      try {
        final location =
            await _locationPerositoryImpl.getCurrentCoordinates("Minsk");

        if (location != null) {
          _localDataSourceImpl.saveLocationToCache(location);
          emit(
            state.copyWith(location: location),
          );
          final weather = await _weatherPerositoryImpl.getCurrentWather(
            location.latitude!,
            location.longitude!,
          );
          if (weather != null) {
            await _localDataSourceImpl.saveLastOnlineSessionTimeToCache(
              DateTime.now().millisecondsSinceEpoch,
            );
            _weatherLocalDataSourceImpl.saveWeatherToCache(weather);

            emit(
              state.copyWith(
                weather: weather,
                isDataLoaded: true,
                isInformationUpToDate: true,
              ),
            );
          }
        }
      } catch (e) {
        throw Exception('loading dara error :( $e');
      }
    } else {
      try {
        final location = await _localDataSourceImpl.getLastLocationFromCache();
        final info = await howOldIsDataInfo();
        final weather =
            await _weatherLocalDataSourceImpl.getLastWeatherFromCache();

        emit(
          state.copyWith(
            location: location,
            title: info,
            weather: weather,
            isDataLoaded: true,
          ),
        );
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  void changeLanguage() {
    final double newTemperatureStep;
    final bool newDegreeType;
    final Map<String, String> newAppDictionary;

    if (state.europeTemperature) {
      newTemperatureStep = 0.0;
      newDegreeType = false;
      newAppDictionary = dictionary.engDictionary;
    } else {
      newTemperatureStep = 273.0;
      newDegreeType = true;
      newAppDictionary = dictionary.ruDictionary;
    }
    emit(
      state.copyWith(
        europeTemperature: newDegreeType,
        temperatureStep: newTemperatureStep,
        appDictionary: newAppDictionary,
      ),
    );
  }

  Future<String> howOldIsDataInfo() async {
    final int lastOnlineSessionTime =
        await _localDataSourceImpl.getLastOnlineSessionTimeFromCache();
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    String infoString;

    final lastOnlineSessionTimeDifference = DateTime.fromMillisecondsSinceEpoch(
        currentTime - lastOnlineSessionTime);
    //final res = '${lastOnlineSessionTimeDifference.day - 1}|${lastOnlineSessionTimeDifference.hour}|${lastOnlineSessionTimeDifference.minute}';

    if (lastOnlineSessionTimeDifference.day - 1 != 0) {
      infoString = "${lastOnlineSessionTimeDifference.day - 1} days ago";
    } else if (lastOnlineSessionTimeDifference.hour != 0) {
      infoString = "${lastOnlineSessionTimeDifference.hour} hours ago";
    } else {
      infoString = "${lastOnlineSessionTimeDifference.minute} minutes ago";
    }

    return infoString;
  }
}
