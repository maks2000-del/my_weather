import 'package:get_it/get_it.dart';
import 'package:my_weather/pages/city_weather/city_weather_cubit.dart';
import 'package:my_weather/pages/home/home_cubit.dart';
import 'package:my_weather/repositories/weather_repository_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_weather/helpers/internet_connection.dart';
import 'package:my_weather/repositories/location_repository_http.dart';
import 'package:my_weather/repositories/location_repository_cache.dart';
import 'package:my_weather/repositories/weather_repository_cache.dart';

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
  final internetConnection = locator.get<InternetConnection>();

  locator.registerFactory<WeatherHttpPerositoryImpl>(
    () => WeatherHttpPerositoryImpl(internetConnection: internetConnection),
  );
  locator.registerFactory<LocationHttpRepositoryImpl>(
    () => LocationHttpRepositoryImpl(internetConnection: internetConnection),
  );
}

Future<void> _setUpCasheDataSorce() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  locator.registerFactory<LocationLocalDataSourceImpl>(
    () => LocationLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );

  locator.registerFactory<WeatherLocalDataSourceImpl>(
    () => WeatherLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );
}

void _setUpCubits() {
  final internetConnection = locator.get<InternetConnection>();
  final weatherHttpPerositoryImpl = locator.get<WeatherHttpPerositoryImpl>();
  final locationHttpRepositoryImpl = locator.get<LocationHttpRepositoryImpl>();
  final weatherLocalDataSourceImpl = locator.get<WeatherLocalDataSourceImpl>();
  final locationLocalDataSourceImpl =
      locator.get<LocationLocalDataSourceImpl>();

  locator.registerFactory<HomeCubit>(
    () => HomeCubit(
      internetConnection: internetConnection,
      locationHttpRepositoryImpl: locationHttpRepositoryImpl,
      locationLocalDataSourceImpl: locationLocalDataSourceImpl,
      weatherLocalDataSourceImpl: weatherLocalDataSourceImpl,
      weatherHttpPerositoryImpl: weatherHttpPerositoryImpl,
    ),
  );
  locator.registerFactory<CityWeatherCubit>(
    () => CityWeatherCubit(
      locationHttpRepositoryImpl: locationHttpRepositoryImpl,
      weatherHttpPerositoryImpl: weatherHttpPerositoryImpl,
    ),
  );
}
