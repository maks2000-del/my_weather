import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_weather/models/info_model.dart';
import 'package:my_weather/models/lacation_model.dart';
import 'package:my_weather/models/weather_model.dart';
import 'package:my_weather/pages/city_weather/city_weather_state.dart';
import 'package:my_weather/repositories/location_repository_http.dart';
import 'package:my_weather/repositories/weather_repository_http.dart';

class CityWeatherCubit extends Cubit<CityWeatherState> {
  CityWeatherCubit({
    required WeatherHttpPerositoryImpl weatherHttpPerositoryImpl,
    required LocationHttpRepositoryImpl locationHttpRepositoryImpl,
  }) : super(
          CityWeatherState(
            isDataLoaded: false,
            weatherHttpPerositoryImpl: weatherHttpPerositoryImpl,
            locationHttpRepositoryImpl: locationHttpRepositoryImpl,
          ),
        );

  void initState(String cityName) async {
    final Location? _location =
        await state.locationHttpRepositoryImpl.getCurrentCoordinates(cityName);

    if (_location != null) {
      final Weather? weather = await state.weatherHttpPerositoryImpl
          .getCurrentWather(_location.latitude!, _location.longitude!);

      if (weather != null) {
        final Info info = weather.currentWeather;

        emit(
          state.copyWith(info: info, isDataLoaded: true),
        );
      }
    }
  }
}
