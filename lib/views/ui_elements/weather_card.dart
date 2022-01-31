import 'package:flutter/material.dart';
import 'package:exomind_case/data/static.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard([this.cityName, this.temp, this.feels, this.icon]);

  final String? cityName;
  final num? temp;
  final num? feels;
  //final String? cloudCoverage;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    String iconUrl = setIcon(icon!);
    String temperature = temp!.toString() + metricStr;
    String tempFeels = feelStr + feels!.toString() + metricStr;

    return Center(
      child: Card(
        elevation: 5,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: Image.network(iconUrl),
                    margin: const EdgeInsets.only(left: 10, right: 10),
                  ),
                  Row(
                    children: [
                      Text(
                        cityName!,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dongle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 70,
                        margin: const EdgeInsets.only(
                          left: 50,
                        ),
                        child: Text(
                          temperature,
                          style: GoogleFonts.dongle(
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                tempFeels,
                style: GoogleFonts.dongle(
                  fontSize: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
