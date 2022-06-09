import 'package:get_it/get_it.dart';
import 'package:my_weather/repositories/weather_repository_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/internet_connection.dart';
import 'repositories/location_repository_http.dart';
import 'repositories/location_repository_cashe.dart';

final locator = GetIt.instance;

Future<void> setUp() async {
  _setUpConnection();
  await _setUpCasheDataSorce();
  _setUpHttpRerositories();
  _setUpCubits();
}

void _setUpConnection() {
  locator.registerSingleton<InternetConnection>(
    InternetConnection(),
  );
}

void _setUpHttpRerositories() {
  locator.registerFactory<WeatherPerositoryImpl>(
    () => WeatherPerositoryImpl(),
  );
  locator.registerFactory<LocationHttpRerositoryImpl>(
    () => LocationHttpRerositoryImpl(),
  );
}

Future<void> _setUpCasheDataSorce() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  locator.registerFactory<LocationLocalDataSourceImpl>(
    () => LocationLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );
}

void _setUpCubits() {}
