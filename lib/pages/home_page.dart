import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helpers/colors.dart' as color;
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
    var _width = MediaQuery.of(context).size.height / 10;
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
            padding: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      state.location?.cityName ?? "city",
                      style: TextStyle(
                        fontSize: 25.0,
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
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.weather?.currentWeather.temperatyre
                                  .toString() ??
                              'lala',
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
                  ),
                ),
                state.weather?.hourWeahter.length == 0
                    ? const Text('loading')
                    : SizedBox(
                        height: _tenthHeigh * 1.5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.weather?.hourWeahter.length ?? 0,
                          itemBuilder: (_, element) {
                            return SizedBox(
                              width: 100.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    state.weather!.hourWeahter[element].date
                                        .toString(),
                                  ),
                                  Text(
                                    state.weather!.hourWeahter[element].iconId
                                        .toString(),
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
                const SizedBox(
                  height: 20.0,
                ),
                state.weather!.dayWeather.length == 0
                    ? Text(state.weather!.dayWeather.length.toString())
                    : SafeArea(
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
                              return SizedBox(
                                height: 35.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      state.weather!.dayWeather[element].date
                                          .toString(),
                                    ),
                                    Text(
                                      state.weather!.dayWeather[element].iconId
                                          .toString(),
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
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
