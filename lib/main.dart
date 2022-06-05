import 'package:flutter/material.dart';
import 'package:my_weather/weather_app.dart';

import 'injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  runApp(const WeatherApp());
}
