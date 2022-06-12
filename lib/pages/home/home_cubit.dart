import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_weather/models/info_model.dart';
import 'package:my_weather/models/weather_model.dart';
import 'package:my_weather/pages/home/home_state.dart';

import 'package:my_weather/helpers/dictionaries.dart' as dictionary;

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required internetConnection,
    required locationHttpRepositoryImpl,
    required weatherHttpPerositoryImpl,
    required locationLocalDataSourceImpl,
    required weatherLocalDataSourceImpl,
  }) : super(
          HomeState(
            title: 'up to date',
            europeTemperature: false,
            isDataLoaded: false,
            isInformationUpToDate: false,
            temperatureStep: 0.0,
            internetConnection: internetConnection,
            locationHttpRepositoryImpl: locationHttpRepositoryImpl,
            weatherHttpPerositoryImpl: weatherHttpPerositoryImpl,
            locationLocalDataSourceImpl: locationLocalDataSourceImpl,
            weatherLocalDataSourceImpl: weatherLocalDataSourceImpl,
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
    await state.internetConnection.checkForInternetConnection();
    if (state.internetConnection.status) {
      try {
        final location = await state.locationHttpRepositoryImpl
            .getCurrentCoordinates("Minsk");

        if (location != null) {
          state.locationLocalDataSourceImpl.saveLocationToCache(location);
          emit(
            state.copyWith(location: location),
          );
          final weather =
              await state.weatherHttpPerositoryImpl.getCurrentWather(
            location.latitude!,
            location.longitude!,
          );
          if (weather != null) {
            await state.locationLocalDataSourceImpl
                .saveLastOnlineSessionTimeToCache(
              DateTime.now().millisecondsSinceEpoch,
            );
            state.weatherLocalDataSourceImpl.saveWeatherToCache(weather);

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
        debugPrint('loading dara error :( $e');
      }
    } else {
      try {
        final location =
            await state.locationLocalDataSourceImpl.getLastLocationFromCache();
        final info = await howOldIsDataInfo();
        final weather =
            await state.weatherLocalDataSourceImpl.getLastWeatherFromCache();

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
    final oldEuropeTemperature = state.europeTemperature;

    emit(
      state.copyWith(
        europeTemperature: oldEuropeTemperature ? false : true,
        temperatureStep: oldEuropeTemperature ? 0.0 : 273.0,
        appDictionary: oldEuropeTemperature
            ? dictionary.engDictionary
            : dictionary.ruDictionary,
      ),
    );
  }

  Future<String> howOldIsDataInfo() async {
    final int lastOnlineSessionTime = await state.locationLocalDataSourceImpl
        .getLastOnlineSessionTimeFromCache();
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    String infoString;

    final lastOnlineSessionTimeDifference = DateTime.fromMillisecondsSinceEpoch(
        currentTime - lastOnlineSessionTime);

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
