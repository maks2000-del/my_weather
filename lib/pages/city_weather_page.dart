import 'package:flutter/material.dart';

import '../helpers/colors.dart' as color;
import '../helpers/icons.dart' as icon;

class CityWeatherPage extends StatelessWidget {
  const CityWeatherPage({Key? key}) : super(key: key);
  //TODO getX parametres
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text(
                cityName,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w300,
                  color: color.AppColor.homePageTitle,
                ),
              ),
              Expanded(child: Container()),
              const IconButton(
                onPressed: null,
                icon: Icon(Icons.arrow_back_ios),
              ),
            ],
          ),
          Center(
            child: Column(
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
                      info.temperatyre.toString(),
                      style: TextStyle(
                        fontSize: 50.0,
                        color: color.AppColor.homePageTitle,
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      europeTemperature ? "C" : "F",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: color.AppColor.homePageSubtitle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
