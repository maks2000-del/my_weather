import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_weather/models/lacation_model.dart';
import 'package:my_weather/models/weather_model.dart';

import '../helpers/colors.dart' as color;
import '../helpers/icons.dart' as icon;
import '../injector.dart';
import '../models/info_model.dart';
import '../repositories/location_repository_http.dart';
import '../repositories/weather_repository_http.dart';

class CityWeatherPage extends StatefulWidget {
  final String cityName;
  final bool europeTemperature;

  const CityWeatherPage({
    Key? key,
    required this.cityName,
    required this.europeTemperature,
  }) : super(key: key);

  @override
  State<CityWeatherPage> createState() => _CityWeatherPageState();
}

class _CityWeatherPageState extends State<CityWeatherPage> {
  Weather? _weather;

  void _getCurrentCityWeather() async {
    final _locationPerositoryImpl = locator.get<LocationHttpRerositoryImpl>();
    final _weatherPerositoryImpl = locator.get<WeatherPerositoryImpl>();

    final Location? _location =
        await _locationPerositoryImpl.getCurrentCoordinates(widget.cityName);

    _weather = await _weatherPerositoryImpl.getCurrentWather(
        _location!.latitude!, _location.longitude!);

    setState(() {});
  }

  @override
  void initState() {
    _getCurrentCityWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        color: color.AppColor.cityPageBackgroundColor,
        child: Column(
          children: [
            _navBar(widget.cityName),
            const SizedBox(
              height: 150.0,
            ),
            _weather != null
                ? _weatherInfo(
                    _weather!.currentWeather,
                    widget.europeTemperature,
                  )
                : const SizedBox(
                    width: 180.0,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballTrianglePathColoredFilled,
                      colors: [
                        Colors.white,
                        Colors.black,
                        Colors.grey,
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

Widget _navBar(String cityName) {
  return Row(
    children: [
      IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios,
          color: color.AppColor.cityPageIcon,
        ),
      ),
      Expanded(child: Container()),
      Text(
        cityName,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w300,
          color: color.AppColor.cityPageIcon,
        ),
      ),
    ],
  );
}

Widget _weatherInfo(Info info, bool europeTemperature) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        width: 120.0,
        icon.assetImages[info.iconId.substring(0, 2)]!,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (info.temperatyre - (europeTemperature ? 273.0 : 0.0))
                .toStringAsFixed(2)
                .toString(),
            style: TextStyle(
              fontSize: 50.0,
              color: color.AppColor.cityPageTitle,
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            europeTemperature ? "C" : "F",
            style: TextStyle(
              fontSize: 30.0,
              color: color.AppColor.cityPageSubtitle,
            ),
          ),
        ],
      ),
    ],
  );
}
