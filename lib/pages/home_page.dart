import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_weather/pages/city_weather_page.dart';
import '../helpers/citys.dart';
import '../helpers/colors.dart' as color;
import '../helpers/icons.dart' as icon;
import 'home_cubit.dart';
import 'home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeCubit _homeCubit = HomeCubit();

  @override
  void initState() {
    _homeCubit.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _tenthHeigh = MediaQuery.of(context).size.height / 10;
    var _width = MediaQuery.of(context).size.width;
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _homeCubit,
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  color.AppColor.firstGradientColor,
                  color.AppColor.secondGradientColor,
                ],
              ),
            ),
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: state.isDataLoaded
                ? Column(
                    children: [
                      _navBar(state),
                      _weatherInfo(
                        _tenthHeigh,
                        state,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _hourWeatherInfo(
                        _tenthHeigh,
                        _width,
                        state,
                      ),
                      _dayWeatherInfo(
                        _tenthHeigh,
                        state,
                      ),
                    ],
                  )
                : const Center(
                    child: SizedBox(
                      width: 150.0,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballRotateChase,
                        colors: [
                          Colors.white,
                          Colors.black,
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _navBar(HomeState state) {
    return Row(
      children: [
        Text(
          '${state.location?.cityName ?? 'city'} | ',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w300,
            color: color.AppColor.homePageTitle,
          ),
        ),
        Text(
          state.title,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
            color: color.AppColor.homePageTitle,
          ),
        ),
        Expanded(child: Container()),
        PopupMenuButton(
          icon: Icon(
            Icons.location_city_rounded,
            color: color.AppColor.homePageIcon,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          color: color.AppColor.homePageMenuBackgroundColor,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context) {
            return citys.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          onSelected: (choice) {
            Get.to(
              () => CityWeatherPage(
                cityName: choice.toString(),
                europeTemperature: state.europeTemperature,
              ),
            );
          },
        ),
        InkWell(
          onTap: () => _homeCubit.changeLanguage(),
          child: Container(
            width: 35.0,
            height: 35.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: color.AppColor.homePageIcon,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                state.europeTemperature ? 'Ru' : 'Eng',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: color.AppColor.homePageIcon,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _weatherInfo(double appTenthHeight, HomeState state) {
    return SizedBox(
      height: appTenthHeight * 3.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            width: 120.0,
            icon.assetImages[
                state.weather!.currentWeather.iconId.substring(0, 2)]!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (state.weather!.currentWeather.temperatyre -
                        state.temperatureStep)
                    .toStringAsFixed(2)
                    .toString(),
                style: TextStyle(
                  fontSize: 50.0,
                  color: color.AppColor.homePageTitle,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                state.europeTemperature ? "C" : "F",
                style: TextStyle(
                  fontSize: 30.0,
                  color: color.AppColor.homePageSubtitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hourWeatherInfo(
    double appTenthHeight,
    double appWidth,
    HomeState state,
  ) {
    return SizedBox(
      height: appTenthHeight * 1.5,
      child: OverflowBox(
        maxWidth: appWidth,
        child: MediaQuery.removePadding(
          removeLeft: true,
          removeRight: true,
          context: context,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (_, element) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                width: 70.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${state.weather!.hourWeahter[element].date.hour.toString()}:00',
                    ),
                    Image.asset(
                      width: 50.0,
                      icon.assetImages[state
                          .weather!.hourWeahter[element].iconId
                          .substring(0, 2)]!,
                    ),
                    Text(
                      (state.weather!.hourWeahter[element].temperatyre -
                              state.temperatureStep)
                          .toStringAsFixed(2)
                          .toString(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _dayWeatherInfo(double appTenthHeigh, HomeState state) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: color.AppColor.homePageBackgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: appTenthHeigh * 2.5,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: state.weather?.dayWeather.length ?? 0,
          itemBuilder: (_, element) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              height: 35.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 30.0,
                    child: Text(
                      '${state.weather!.dayWeather[element].date.month.toString()}/${state.weather!.dayWeather[element].date.day.toString()}',
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    weekDayName(
                      state.weather!.dayWeather[element].date.weekday,
                    ),
                  ),
                  Expanded(child: Container()),
                  Image.asset(
                    icon.assetImages[state.weather!.dayWeather[element].iconId
                        .substring(0, 2)]!,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  SizedBox(
                    width: 45.0,
                    child: Text(
                      (state.weather!.dayWeather[element].temperatyre -
                              state.temperatureStep)
                          .toStringAsFixed(2)
                          .toString(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String weekDayName(int num) {
    final String name;
    switch (num) {
      case 1:
        name = "Monday";
        break;
      case 2:
        name = "Tuesday";
        break;
      case 3:
        name = "Wednesday";
        break;
      case 4:
        name = "Thursday";
        break;
      case 5:
        name = "Friday";
        break;
      case 6:
        name = "Saturday";
        break;
      case 7:
        name = "Sunday";
        break;
      default:
        name = "today";
        break;
    }
    return name;
  }
}
