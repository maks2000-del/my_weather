import 'package:get_it/get_it.dart';
import 'package:my_weather/repositories/weather_repository_http.dart';

import 'helpers/internet_connection.dart';
import 'repositories/location_repository_http.dart';

final locator = GetIt.instance;

void setUp() {
  _setUpConnection();
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
  locator.registerFactory<LocationPerositoryImpl>(
    () => LocationPerositoryImpl(),
  );
}

void _setUpCubits() {}
