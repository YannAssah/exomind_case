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
  late Future<List<Forecast>> citiesForecast;

  @override
  void initState() {
    super.initState();
    //cityForecast = fetchForecast("paris");
    citiesForecast = fetchCast();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder<List<Forecast>>(
              future: citiesForecast,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Forecast> result = snapshot.data!;
                  return ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        //print(result[index].name!);
                        Timer(const Duration(seconds: 10), () {});
                        return WeatherCard(
                            result[index].name!,
                            result[index].main!.temp!.toInt(),
                            result[index].main!.feelsLike!.toInt(),
                            result[index].weather![0].icon);
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          ElevatedButton(
            child: const Text("Refresh"),
            onPressed: () => {},
          )
        ],
      ),
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

  Future<List<Forecast>> fetchCast() async {
    List<Forecast> temp = [];
    for (var city in cities) {
      final String finalUrl = midUrl + city;
      final response = await http.get(Uri.parse(finalUrl));

      if (response.statusCode == 200) {
        temp.add(Forecast.fromJson(jsonDecode(response.body)));
        //return Forecast.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load Forecast Data');
      }
    }
    return temp;
  }

  //Future<>
}
