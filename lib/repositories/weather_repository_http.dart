import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:my_weather/helpers/internet_connection.dart';
import 'package:my_weather/models/weather_model.dart';

import 'package:http/http.dart' as http;

abstract class WeatherHttpPerository {
  Future<Weather?> getCurrentWather(double lat, double lon);
}

class WeatherHttpPerositoryImpl implements WeatherHttpPerository {
  final InternetConnection internetConnection;
  final _apiKey = "c8e0382199b302c66ba31651d6a15c26";

  WeatherHttpPerositoryImpl({required this.internetConnection});

  @override
  Future<Weather?> getCurrentWather(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${internetConnection.apiUrl}data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=$_apiKey",
        ),
      );

      if (response.statusCode == 200) {
        final weather = Weather.fromJson(json.decode(response.body));

        return weather;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
