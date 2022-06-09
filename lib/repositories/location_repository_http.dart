//http://api.openweathermap.org/geo/1.0/direct?q=London&limit=1&appid=c8e0382199b302c66ba31651d6a15c26

import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:my_weather/models/lacation_model.dart';

import '../helpers/internet_connection.dart';

import 'package:http/http.dart' as http;

abstract class LocationHttpRerository {
  Future<Location?> getCurrentCoordinates(String cityName);
}

class LocationHttpRerositoryImpl implements LocationHttpRerository {
  final _internetConnection = GetIt.instance.get<InternetConnection>();
  final apiKey = "c8e0382199b302c66ba31651d6a15c26";

  @override
  Future<Location?> getCurrentCoordinates(String cityName) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${_internetConnection.apiUrl}geo/1.0/direct?q=$cityName&limit=1&appid=$apiKey",
        ),
      );

      if (response.statusCode == 200) {
        final location = Location.fromJson(json.decode(response.body)[0]);
        return location;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
