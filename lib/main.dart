import 'package:flutter/material.dart';
import 'package:my_weather/weather_app.dart';

import 'injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();

  runApp(
    const WeatherApp(),
  );
}
