// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'dart:convert';

import 'package:exomind_case/Model/forecast.dart';
import 'package:exomind_case/data/static.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  Future<Forecast> fetchForecast(String city) async {
    //print(cities);
    final String finalUrl = midUrl + city;
    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      return Forecast.fromJson(jsonDecode(response.body));
    } else {
      throw exceptionHandler(response);
    }
  }

  Future<List<Forecast>> fetchAll() async {
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
        throw exceptionHandler(response);
      }
    }
    return temp;
  }

  Future<List<Forecast>> fetchPeriodic() async {
    List<Forecast> temp = [];
    for (var city in cities) {
      final String finalUrl = midUrl + city;
      final response = await http.get(Uri.parse(finalUrl));
      //Future.delayed(Duration(seconds: 10));
      if (response.statusCode == 200) {
        Future.delayed(const Duration(seconds: 2));
        temp.add(Forecast.fromJson(jsonDecode(response.body)));
        //print(response.body);
        //return Forecast.fromJson(jsonDecode(response.body));
      } else {
        throw exceptionHandler(response);
      }
    }
    return temp;
  }

  static dynamic exceptionHandler(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class AppException implements Exception {
  // ignore: prefer_typing_uninitialized_variables
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
