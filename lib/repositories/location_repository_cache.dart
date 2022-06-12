import 'dart:convert';

import 'package:my_weather/models/lacation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocationLocalDataSource {
  Future<Location> getLastLocationFromCache();
  Future<void> saveLocationToCache(Location location);
  Future<int> getLastOnlineSessionTimeFromCache();
  Future<void> saveLastOnlineSessionTimeToCache(int timestamp);
}

class LocationLocalDataSourceImpl extends LocationLocalDataSource {
  static String cashedLocation = "CASHED_LOCATION";
  static String cashedLastOnlineSessionTime = "LAST_ONLINE";

  final SharedPreferences sharedPreferences;

  LocationLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Location> getLastLocationFromCache() async {
    final jsonLocation = sharedPreferences.getString(cashedLocation);
    if (jsonLocation != null) {
      return Future.value(Location.fromJson(json.decode(jsonLocation)));
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> saveLocationToCache(Location location) async {
    final String jsonLocation = json.encode(location.toMap(location));

    sharedPreferences.setString(cashedLocation, jsonLocation);
  }

  @override
  Future<int> getLastOnlineSessionTimeFromCache() async {
    final timestamp = sharedPreferences.getInt(cashedLastOnlineSessionTime);
    if (timestamp != null) {
      return timestamp;
    } else {
      throw Exception();
    }
  }

  @override
  Future<void> saveLastOnlineSessionTimeToCache(int timestamp) async {
    sharedPreferences.setInt(cashedLastOnlineSessionTime, timestamp);
  }
}
