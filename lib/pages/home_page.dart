import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    var _width = MediaQuery.of(context).size.height;
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
            padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Row(
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
                      'up to date',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                        color: color.AppColor.homePageTitle,
                      ),
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () => _homeCubit.changeTemperatureDegreeType(),
                      child: Icon(
                        state.europeTemperature ? Icons.info : Icons.facebook,
                        size: 30.0,
                        color: color.AppColor.homePageIcons,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _tenthHeigh * 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.isDataLoaded
                          ? Image.asset(
                              width: 120.0,
                              icon.assetImages[state
                                  .weather!.currentWeather.iconId
                                  .substring(0, 2)]!,
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.weather?.currentWeather.temperatyre
                                    .toString() ??
                                'waiting for data',
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
                ),
                state.isDataLoaded
                    //TODO problems with right and left padding (some data crops)
                    ? SizedBox(
                        height: _tenthHeigh * 1.5,
                        child: OverflowBox(
                          maxWidth: _width,
                          child: MediaQuery.removePadding(
                            removeRight: true,
                            removeLeft: true,
                            context: context,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.weather?.hourWeahter.length ?? 0,
                              itemBuilder: (_, element) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  width: 60.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        '${state.weather!.hourWeahter[element].date.hour.toString()}:00',
                                      ),
                                      Image.asset(
                                        width: 50.0,
                                        icon.assetImages[state.weather!
                                            .hourWeahter[element].iconId
                                            .substring(0, 2)]!,
                                      ),
                                      Text(
                                        state.weather!.hourWeahter[element]
                                            .temperatyre
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : const Text('loading..'),
                const SizedBox(
                  height: 20.0,
                ),
                state.isDataLoaded
                    ? SafeArea(
                        child: Container(
                          decoration: BoxDecoration(
                            color: color.AppColor.backgroundColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: _tenthHeigh * 2.5,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: state.weather?.dayWeather.length ?? 0,
                            itemBuilder: (_, element) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                        state.weather!.dayWeather[element].date
                                            .weekday,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Image.asset(
                                      icon.assetImages[state
                                          .weather!.dayWeather[element].iconId
                                          .substring(0, 2)]!,
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      state.weather!.dayWeather[element]
                                          .temperatyre
                                          .toString(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const Text('loading..'),
              ],
            ),
          ),
        );
      },
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
