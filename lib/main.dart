import 'package:flutter/material.dart';

import 'package:my_weather/pages/weather_app.dart';
import 'package:my_weather/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();

  runApp(
    const WeatherApp(),
  );
}
