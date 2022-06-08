import 'dart:convert';

import 'package:get_it/get_it.dart';

import '../helpers/internet_connection.dart';

import 'package:http/http.dart' as http;

import '../models/weather_entity.dart';

abstract class WeatherPerository {
  Future<Weather?> getCurrentWather(double lat, double lon);
}

class WeatherPerositoryImpl implements WeatherPerository {
  final _internetConnection = GetIt.instance.get<InternetConnection>();
  final apiKey = "c8e0382199b302c66ba31651d6a15c26";

  @override
  Future<Weather?> getCurrentWather(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${_internetConnection.apiUrl}data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=$apiKey",
        ),
      );

      if (response.statusCode == 200) {
        final weather = Weather.fromJson(json.decode(response.body));

        return weather;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
