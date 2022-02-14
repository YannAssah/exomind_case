import 'dart:async';

import 'package:exomind_case/bloc_implementation/bloc/bloc/forecast_bloc.dart';
import 'package:exomind_case/bloc_implementation/views/ui_elements/weather_list.dart';
import 'package:exomind_case/old/Model/forecast.dart';
import 'package:exomind_case/old/data/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late Future<Forecast> cityForecast;
  late Future<List<Forecast>> citiesForecast;
  ForecastLoading initial = ForecastLoading();

  bool isLoading = true;
  bool reset = false;
  double percent = 0;

  List<String> progressTextList = [progressStr1, progressStr2, progressStr3];
  String progress = "";
  final ForecastBloc forecastBloc = ForecastBloc();

  @override
  void initState() {
    // Initiate getting the weather
    forecastBloc.add(GetForecast());
    super.initState();
    //citiesForecast = fetchCast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Météo'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: BlocBuilder<ForecastBloc, ForecastState>(
        bloc: forecastBloc,
        builder: (BuildContext context, ForecastState state) {
          if (state is ForecastLoaded) {
            return WeatherList(
              data: state.forecast,
            );
          } else if (state is ForecastLoading) {
            return buildLoading();
          } else {
            return buildLoading();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Don't forget to call dispose on the Bloc to close the Streams!
    forecastBloc.close();
  }
}

Widget buildLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
