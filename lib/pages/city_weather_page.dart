import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weather/pages/home_state.dart';

import '../helpers/colors.dart' as color;
import '../helpers/icons.dart' as icon;

class CityWeatherPage extends StatelessWidget {
  final String cityName = Get.find();
  final HomeState homeState = Get.find();

  CityWeatherPage({Key? key}) : super(key: key);
  //TODO getX parametres
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
                  cityName,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  width: 120.0,
                  icon.assetImages[homeState.weather!.currentWeather.iconId
                      .substring(0, 2)]!,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (homeState.weather!.currentWeather.temperatyre -
                              homeState.temperatureStep)
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
                      homeState.europeTemperature ? "C" : "F",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: color.AppColor.cityPageSubtitle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
