import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/injector.dart';
import 'package:my_weather/models/info_model.dart';
import 'package:my_weather/models/weather_entity.dart';

import '../repositories/location_repository_http.dart';
import '../repositories/weather_repository_http.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(
            title: '',
            europeTemperature: true,
            weather: Weather(
              currentWeather: Info(
                date: DateTime.now(),
                temperatyre: 0.0,
                iconId: '',
              ),
              hourWeahter: [],
              dayWeather: [],
            ),
          ),
        );
  final _locationPerositoryImpl = locator.get<LocationPerositoryImpl>();
  final _weatherPerositoryImpl = locator.get<WeatherPerositoryImpl>();

  void initState() async {
    final location =
        await _locationPerositoryImpl.getCurrentCoordinates("Minsk");

    final weather = await _weatherPerositoryImpl.getCurrentWather(
      location!.latitude!,
      location.longitude!,
    );

    emit(
      state.copyWith(location: location, weather: weather),
    );
  }

  void changeTemperatureDegreeType() {
    final newDegreeType = state.europeTemperature ? false : true;
    emit(
      state.copyWith(europeTemperature: newDegreeType),
    );
  }
}
