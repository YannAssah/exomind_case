import 'package:flutter/material.dart';
import 'package:exomind_case/data/static.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard([this.cityName, this.temp, this.feels, this.icon]);

  final String? cityName;
  final int? temp;
  final int? feels;
  //final String? cloudCoverage;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    String iconUrl = setIcon(icon!);

    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(.2),
            width: 1,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.network(iconUrl),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(cityName!),
                  )
                ],
              ),
              Text(tempStr + temp.toString() + metricStr),
              Text(feelStr + feels.toString() + metricStr)
            ],
          ),
        ),
      ),
    );
  }
}
