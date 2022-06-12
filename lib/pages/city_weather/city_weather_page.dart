import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:my_weather/injector.dart';
import 'package:my_weather/models/info_model.dart';
import 'package:my_weather/pages/city_weather/city_weather_cubit.dart';
import 'package:my_weather/pages/city_weather/city_weather_state.dart';

import 'package:my_weather/helpers/colors.dart' as color;
import 'package:my_weather/helpers/icons.dart' as icon;

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
  final CityWeatherCubit _cityWeatherCubit = locator.get<CityWeatherCubit>();

  @override
  void initState() {
    _cityWeatherCubit.initState(widget.cityName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CityWeatherCubit, CityWeatherState>(
      bloc: _cityWeatherCubit,
      builder: (context, state) {
        return Scaffold(
          body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
            color: color.AppColor.cityPageBackgroundColor,
            child: Column(
              children: [
                _navBar(widget.cityName),
                const SizedBox(
                  height: 150.0,
                ),
                state.isDataLoaded
                    ? _weatherInfo(
                        state.info!,
                        widget.europeTemperature,
                      )
                    : SizedBox(
                        width: 180.0,
                        child: LoadingIndicator(
                          indicatorType:
                              Indicator.ballTrianglePathColoredFilled,
                          colors: [
                            color.AppColor.cityPageLoadingIndicatorColorOne,
                            color.AppColor.cityPageLoadingIndicatorColorTwo,
                            color.AppColor.cityPageLoadingIndicatorColorThree,
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      },
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
      const Spacer(),
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
