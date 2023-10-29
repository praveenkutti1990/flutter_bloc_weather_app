import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_weather/bloc/day_weather_bloc.dart';
import 'package:flutter_bloc_weather/cubit/get_cords_cubit.dart';
import 'package:flutter_bloc_weather/repos/day_weather_repo.dart';
import 'package:flutter_bloc_weather/repos/location_repo.dart';
import 'package:http/http.dart' as http;
import 'bloc/location_bloc.dart';
import 'models/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => LocationRepository(),
          ),
          RepositoryProvider(
            create: (context) => DayWeatherRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetCordsCubit(),
            ),
            BlocProvider(
              create: (context) => LocationBloc(
                  RepositoryProvider.of<LocationRepository>(context)),
            ),
            BlocProvider(
              create: (context) => DayWeatherBloc(
                  RepositoryProvider.of<DayWeatherRepository>(context)),
            ),
          ],
          child: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController city_text_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<GetCordsCubit>(context).getCordinates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double lat = 0, lon = 0;

    return Scaffold(
      body: BlocBuilder<GetCordsCubit, GetCordsState>(
        builder: (context, state) {
          lat = state.lat;
          lon = state.lon;
          return SafeArea(
            child: state.loaded
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: Text('Get Weather'),
                          onPressed: () {
                            BlocProvider.of<LocationBloc>(context)
                                .add(LoadLocationEvent(lat, lon));
                            BlocProvider.of<DayWeatherBloc>(context)
                                .add(LoadDayWeatherEvent());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, state) {
                            if (state is LocationLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is LocationLoadedState) {
                              return Text(
                                state.location.city.toString(),
                                style: const TextStyle(fontSize: 20),
                              );
                            } else if (state is LocationLoadErrorState) {
                              return Text(
                                state.error,
                                style: const TextStyle(fontSize: 20),
                              );
                            }
                            return Text("");
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<DayWeatherBloc, DayWeatherState>(
                          builder: (context, state) {
                            if (state is DayWeatherLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is DayWeatherLoadedState) {
                              return Expanded(
                                child: ListView.builder(
                                    itemCount: state.dayWeather.daily!
                                        .temperature2mMax?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 2, color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          leading: const Icon(
                                            Icons.sunny,
                                            color: Colors.orangeAccent,
                                            size: 50,
                                          ),
                                          title: Text(
                                              state.dayWeather.daily!
                                                  .time![index],
                                              style: const TextStyle(
                                                  fontSize: 20)),
                                          trailing: Text(
                                              '${state.dayWeather.daily!.temperature2mMax![index]}/${state.dayWeather.daily!.temperature2mMin![index]}',
                                              style: const TextStyle(
                                                  fontSize: 20)),
                                        ),
                                      );
                                    }),
                              );
                            } else if (state is DayWeatherErrorState) {
                              return Text(
                                state.error,
                                style: const TextStyle(fontSize: 20),
                              );
                            }
                            return Text("");
                          },
                        )
                      ],
                    ),
                  )
                : const Center(
                    child: Text(
                    "Error Occured",
                    style: TextStyle(fontSize: 20),
                  )),
          );
        },
      ),
    );
  }
}
