import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../helpers/internet_connection.dart';

import 'package:http/http.dart' as http;

import '../models/weather_entity.dart';

abstract class WeatherPerository {
  Future<Weather?> getCurrentWather();
}
//https://api.openweathermap.org/data/2.5/weather?lat=51.5073219&lon=-0.1276474&appid=c8e0382199b302c66ba31651d6a15c26

//https://api.openweathermap.org/data/2.5/onecall?lat=51.5073219&lon=-0.1276474&exclude=minutely,alerts&appid=c8e0382199b302c66ba31651d6a15c26

class WeatherPerositoryImpl implements WeatherPerository {
  final _internetConnection = GetIt.instance.get<InternetConnection>();

  @override
  Future<Weather?> getCurrentWather() async {
    try {
      final uesrResponse = await http.get(
        Uri.parse("${_internetConnection.apiUrl}"),
      );

      if (uesrResponse.statusCode == 200) {
        final weather = Weather.fromJson(jsonDecode(uesrResponse.body));
        return weather;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
