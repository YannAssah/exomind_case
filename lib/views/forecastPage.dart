import 'dart:convert';
import 'dart:async';

import 'package:exomind_case/data/weather.dart';
import 'package:exomind_case/views/ui_elements/weather_card.dart';
import 'package:exomind_case/data/static.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late Future<Forecast> cityForecast;
  //String apiUrl =
  //'https://api.openweathermap.org/data/2.5/weather?q=bordeaux&units=metric&appid=61600c95368cd732fd6fb6a9d1bc1585';

  @override
  void initState() {
    super.initState();
    //cityForecast = fetchForecast("paris");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder<Forecast>(
          future: cityForecast,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WeatherCard(
                snapshot.data!.name!,
                snapshot.data!.main!.temp!,
                snapshot.data!.main!.feelsLike!,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        )
      ],
    );
  }

  Future<Forecast> fetchForecast(String city) async {
    //print(cities);
    final String finalUrl = midUrl + city;
    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      return Forecast.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Forecast Data');
    }
  }
}
