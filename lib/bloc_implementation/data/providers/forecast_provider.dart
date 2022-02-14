import 'dart:async';
import 'package:exomind_case/bloc_implementation/constant.dart';
import 'package:http/http.dart' as http;

class ForecastProvider {
  // Future<List<Forecast>> fetchAll() async {
  //   List<Forecast> temp = [];
  //   for (var city in cities) {
  //     final String finalUrl = midUrl + city;
  //     final response = await http.get(Uri.parse(finalUrl));

  //     if (response.statusCode == 200) {
  //       temp.add(Forecast.fromJson(jsonDecode(response.body)));
  //     } else {
  //       throw exceptionHandler(response);
  //     }
  //   }
  //   return temp;
  // }

  Future<List<http.Response>> fetchAllForecast() async {
    List<http.Response> data = [];
    for (var city in cities) {
      final String finalUrl = midUrl + city;
      final response = await http.get(Uri.parse(finalUrl));

      if (response.statusCode == 200) {
        data.add(response);
      } else {
        throw exceptionHandler(response);
      }
    }
    return data;
  }

  Future<http.Response> fetchForecast(String city) async {
    final String finalUrl = midUrl + city;
    final response = await http.get(Uri.parse(finalUrl));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw exceptionHandler(response);
    }
  }

  // Future<Forecast> fetchForecast(String city) async {
  //   final String finalUrl = midUrl + city;
  //   final response = await http.get(Uri.parse(finalUrl));

  //   if (response.statusCode == 200) {
  //     return Forecast.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw exceptionHandler(response);
  //   }
  // }

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
  UnauthorisedException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
