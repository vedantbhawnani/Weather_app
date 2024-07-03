// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../bloc/home_bloc.dart';
import '../data/weather_codes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    bool darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    Color backgroundColor = darkMode
        ? const Color.fromRGBO(47, 54, 67, 1)
        : const Color.fromRGBO(226, 234, 242, 1);

    DateTime today = DateTime.now();

    // TODO: On first time, ask user for name.

    return Scaffold(
        backgroundColor: backgroundColor,
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listenWhen: (previous, current) => current is HomeActionState,
          buildWhen: (previous, current) => current is! HomeActionState,
          listener: (context, state) {
            if (state is HomeGetLocationActionState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("got current location!")));
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case HomeLoadingState:
                return Center(
                  child: Text("Loading the weather for you !"),
                );
              case HomeSuccessState:
                final success = state as HomeSuccessState;
                Map<String, dynamic> currentWeather = success.weatherData;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: height / 10)),
                    Text(success.currAddress, style: textTheme.headlineSmall),
                    Text(
                      "${today.hour}:${today.minute} | ${DateFormat('EEEE').format(today)}",
                      style: textTheme.headlineSmall,
                    ),
                    Padding(padding: EdgeInsets.only(top: height / 8)),
                    SvgPicture.asset(
                      WeatherConditions.getWeatherCondition(
                          currentWeather['weather'][0]['id'])['image']!,
                      colorFilter: darkMode
                          ? const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn)
                          : const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                      height: height / 6,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.05),
                      child: Text(
                        "${(currentWeather['main']['temp'].round() - 273.15).round()}°",
                        style: textTheme.labelLarge,
                      ),
                    ),
                    Text("${currentWeather['weather'][0]['description']}",
                        style: textTheme.bodyMedium),
                    Text(
                        "Feels like: ${(currentWeather['main']['feels_like'] - 273.15).round()}°",
                        style: textTheme.bodySmall),
                    Padding(padding: EdgeInsets.only(top: height / 8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            // mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Wind",
                                style: textTheme.labelSmall,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: height / 100)),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.air),
                                    Text(
                                      " ${currentWeather['wind']['speed']}m/s",
                                      style: textTheme.bodySmall,
                                    ),
                                  ]),
                            ]),
                        const SizedBox(width: 5),
                        const Text('  |  '),
                        const SizedBox(width: 5),
                        Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Humidity", style: textTheme.labelSmall),
                              Padding(
                                  padding: EdgeInsets.only(top: height / 100)),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/humidity.png',
                                      height: 20,
                                      color: darkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    Text(
                                      " ${currentWeather['main']['humidity']}%",
                                      style: textTheme.bodySmall,
                                    ),
                                  ]),
                            ]),
                        const SizedBox(width: 5),
                        // const Text('  |  '),
                        // const SizedBox(width: 5),
                        // Column(
                        //     // mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       Text("Rain", style: textTheme.labelSmall),
                        //       Padding(
                        //           padding: EdgeInsets.only(top: height / 100)),
                        //       Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             Image.asset(
                        //               'assets/icons/rain.png',
                        //               height: 20,
                        //               color: darkMode
                        //                   ? Colors.white
                        //                   : Colors.black,
                        //             ),
                        //             Text(
                        //               " {currentWeather['rain']['1h']}mm",
                        //               style: textTheme.bodySmall,
                        //             ),
                        //           ]),
                        //     ]),
                      ],
                    ),
                  ],
                );
              case HomeErrorState:
                final errorState = state as HomeErrorState;
                return Center(child: Text("${errorState.message}"));
              default:
                return Center(
                  child: Text("Error"),
                );
            }
          },
        ));
  }
}
