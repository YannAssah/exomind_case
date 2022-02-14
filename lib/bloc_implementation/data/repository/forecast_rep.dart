import 'dart:async';
import 'dart:convert';
import 'package:exomind_case/bloc_implementation/data/model/forecast.dart';
import 'package:exomind_case/bloc_implementation/data/providers/forecast_provider.dart';
import 'package:exomind_case/bloc_implementation/constant.dart';
import 'package:http/http.dart' as http;

class ForecastRepository {
  String city1 = cities[0];
  String city2 = cities[1];
  String city3 = cities[2];
  String city4 = cities[3];
  String city5 = cities[4];

  Future<List<Forecast>> decodeAllForecast() async {
    List<http.Response> responses = await ForecastProvider().fetchAllForecast();
    List<Forecast> list = [];
    for (var item in responses) {
      list.add(Forecast.fromJson(jsonDecode(item.body)));
    }
    return list;
  }

  Stream<Forecast> decodeStreamForecast() async* {
    http.Response firstCity = await ForecastProvider().fetchForecast(city1);
    Forecast rennes = Forecast.fromJson(jsonDecode(firstCity.body));
    yield rennes;

    Future.delayed(const Duration(seconds: 10));
    http.Response secondCity = await ForecastProvider().fetchForecast(city2);
    Forecast paris = Forecast.fromJson(jsonDecode(secondCity.body));
    yield paris;

    Future.delayed(const Duration(seconds: 10));
    http.Response thirdCity = await ForecastProvider().fetchForecast(city3);
    Forecast nantes = Forecast.fromJson(jsonDecode(thirdCity.body));
    yield nantes;

    Future.delayed(const Duration(seconds: 10));
    http.Response fourthCity = await ForecastProvider().fetchForecast(city4);
    Forecast bordeaux = Forecast.fromJson(jsonDecode(fourthCity.body));
    yield bordeaux;

    Future.delayed(const Duration(seconds: 10));
    http.Response fifthCity = await ForecastProvider().fetchForecast(city5);
    Forecast lyon = Forecast.fromJson(jsonDecode(fifthCity.body));
    yield lyon;
  }

  Future<Forecast> decodeOneForecast(String city) async {
    http.Response response = await ForecastProvider().fetchForecast(city);
    Forecast forecast = Forecast.fromJson(jsonDecode(response.body));
    return forecast;
  }
}
