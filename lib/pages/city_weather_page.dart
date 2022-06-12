import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_weather/models/lacation_model.dart';
import 'package:my_weather/models/weather_model.dart';

import '../helpers/colors.dart' as color;
import '../helpers/icons.dart' as icon;
import '../injector.dart';
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
  final _locationPerositoryImpl = locator.get<LocationHttpRerositoryImpl>();
  final _weatherPerositoryImpl = locator.get<WeatherPerositoryImpl>();
  Weather? weather;

  void getCurrentCityWeather() async {
    final Location? location =
        await _locationPerositoryImpl.getCurrentCoordinates(widget.cityName);

    weather = await _weatherPerositoryImpl.getCurrentWather(
        location!.latitude!, location.longitude!);
    setState(() {});
  }

  @override
  void initState() {
    getCurrentCityWeather();
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
            Row(
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
                  widget.cityName,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w300,
                    color: color.AppColor.cityPageIcon,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 150.0,
            ),
            weather != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        width: 120.0,
                        icon.assetImages[
                            weather!.currentWeather.iconId.substring(0, 2)]!,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (weather!.currentWeather.temperatyre -
                                    (widget.europeTemperature ? 273.0 : 0.0))
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
                            widget.europeTemperature ? "C" : "F",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: color.AppColor.cityPageSubtitle,
                            ),
                          ),
                        ],
                      ),
                    ],
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
