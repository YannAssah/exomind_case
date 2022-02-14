import 'dart:convert';
import 'dart:async';

import 'package:exomind_case/old/Model/forecast.dart';
import 'package:exomind_case/old/views/ui_elements/weather_card.dart';
import 'package:exomind_case/old/data/static.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:exomind_case/Old/views/ui_elements/progress_bar.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late Future<Forecast> cityForecast;
  late Future<List<Forecast>> citiesForecast;

  bool isLoading = true;
  bool reset = false;
  double percent = 0;

  List<String> progressTextList = [progressStr1, progressStr2, progressStr3];
  String progress = "";

  @override
  void initState() {
    loading();
    super.initState();
    citiesForecast = fetchCast();
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
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: isLoading
                    ? ProgressBar(
                        isLoading: isLoading,
                        percent: percent.toDouble(),
                        prgrssText: progress,
                      )
                    : Column(
                        children: [
                          FutureBuilder<List<Forecast>>(
                            future: citiesForecast,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Forecast> result = snapshot.data!;
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: result.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      return WeatherCard(
                                          result[index].name!,
                                          result[index].main!.temp!.toDouble(),
                                          result[index]
                                              .main!
                                              .feelsLike!
                                              .toDouble(),
                                          result[index].weather![0].icon);
                                    });
                              } else if (snapshot.hasError) {
                                return Text(
                                  '${snapshot.error}',
                                  style: GoogleFonts.dongle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                );
                              }
                              return LinearProgressIndicator(
                                value: percent.toDouble(),
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.blue),
                                backgroundColor: Colors.white,
                              );
                              ;
                            },
                          ),
                          ElevatedButton(
                            child: const Text("Refresh"),
                            onPressed: () => {
                              setState(() {
                                isLoading = true;
                                percent = 0;
                                citiesForecast = fetchCast();
                                loading();
                              })
                            },
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
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
      //Future.delayed(Duration(seconds: 10));

      if (response.statusCode == 200) {
        temp.add(Forecast.fromJson(jsonDecode(response.body)));
        //print(response.body);
        //return Forecast.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load Forecast Data');
      }
    }
    return temp;
  }

  void loading() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        percent += 0.1666;
        //percent += 0.333;
        if (percent >= 1) {
          _.cancel();
          isLoading = false;
          print("Done");
          // percent=0;
        }
      });
    });
  }

  Future<void> _refresh() async {
    setState(() {
      isLoading = true;
      percent = 0;
      citiesForecast = fetchCast();
      loading();
    });
  }
}
