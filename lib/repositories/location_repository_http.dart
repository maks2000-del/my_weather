import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:my_weather/models/lacation_model.dart';
import 'package:my_weather/helpers/internet_connection.dart';

import 'package:http/http.dart' as http;

abstract class LocationHttpRepository {
  Future<Location?> getCurrentCoordinates(String cityName);
}

class LocationHttpRepositoryImpl implements LocationHttpRepository {
  final InternetConnection internetConnection;

  LocationHttpRepositoryImpl({required this.internetConnection});

  final _apiKey = "c8e0382199b302c66ba31651d6a15c26";

  @override
  Future<Location?> getCurrentCoordinates(String cityName) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${internetConnection.apiUrl}geo/1.0/direct?q=$cityName&limit=1&appid=$_apiKey",
        ),
      );

      if (response.statusCode == 200) {
        final location = Location.fromJson(json.decode(response.body)[0]);
        return location;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
