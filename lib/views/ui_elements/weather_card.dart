import 'package:flutter/material.dart';
import 'package:exomind_case/data/static.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard(this.cityName, this.temp, this.feels, [this.cloudCoverage]);

  final String cityName;
  final double temp;
  final double feels;
  final String? cloudCoverage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // if you need this
          side: BorderSide(
            color: Colors.grey.withOpacity(.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(cityName),
            Text(tempStr + temp.toString() + metricStr),
            Text(feelStr + feels.toString() + metricStr)
          ],
        ),
      ),
    );
  }
}
