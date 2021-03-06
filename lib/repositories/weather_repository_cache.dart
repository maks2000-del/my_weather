import 'dart:convert';

import 'package:my_weather/models/info_model.dart';
import 'package:my_weather/models/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WeatherLocalDataSource {
  Future<Weather> getLastWeatherFromCache();
  Future<void> saveWeatherToCache(Weather weather);
}

class WeatherLocalDataSourceImpl extends WeatherLocalDataSource {
  final String cashedCurrentWeather = "CASHED_CURRENT_WEATHER";
  final String cashedHourWeathe = "CASHED_HOUR_WEATHER";
  final String cashedDayWeathe = "CASHED_DAY_WEATHER";

  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Weather> getLastWeatherFromCache() async {
    final jsonCurrentWeather =
        sharedPreferences.getString(cashedCurrentWeather);
    final jsonHourWeathe = sharedPreferences.getStringList(cashedHourWeathe);
    final jsonDayWeathe = sharedPreferences.getStringList(cashedDayWeathe);

    if (jsonCurrentWeather != null &&
        jsonHourWeathe != null &&
        jsonDayWeathe != null) {
      if (jsonHourWeathe.isNotEmpty && jsonDayWeathe.isNotEmpty) {
        final currentWeather = await Future.value(
          Info.fromLocalJson(
            json.decode(jsonCurrentWeather),
          ),
        );

        final hourWeathe = await Future.value(jsonHourWeathe
            .map(
              (info) => Info.fromLocalJson(json.decode(info)),
            )
            .toList());

        hourWeathe.sort((a, b) => a.date.millisecondsSinceEpoch
            .compareTo(b.date.millisecondsSinceEpoch));

        final dayWeathe = await Future.value(jsonDayWeathe
            .map(
              (info) => Info.fromLocalJson(json.decode(info)),
            )
            .toList());

        dayWeathe.sort((a, b) => a.date.millisecondsSinceEpoch
            .compareTo(b.date.millisecondsSinceEpoch));

        return Weather(
          currentWeather: currentWeather,
          hourWeahter: hourWeathe,
          dayWeather: dayWeathe,
        );
      } else {
        throw Exception("weahter lists are empty");
      }
    } else {
      throw Exception("no local data");
    }
  }

  @override
  Future<void> saveWeatherToCache(Weather weather) async {
    final String jsonCurrentWeather = json.encode(
      Info.toMap(weather.currentWeather),
    );
    final Iterable<String> jsonHourWeathe = weather.hourWeahter.map(
      (info) => json.encode(
        Info.toMap(info),
      ),
    );

    final Iterable<String> jsonDayWeathe = weather.dayWeather.map(
      (info) => json.encode(
        Info.toMap(info),
      ),
    );

    sharedPreferences.setString(cashedCurrentWeather, jsonCurrentWeather);
    sharedPreferences.setStringList(cashedHourWeathe, jsonHourWeathe.toList());
    sharedPreferences.setStringList(cashedDayWeathe, jsonDayWeathe.toList());
  }
}
