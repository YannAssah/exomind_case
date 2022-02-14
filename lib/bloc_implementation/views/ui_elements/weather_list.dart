import 'package:exomind_case/bloc_implementation/views/ui_elements/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:exomind_case/bloc_implementation/data/model/forecast.dart';

class WeatherList extends StatelessWidget {
  const WeatherList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<Forecast> data;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text("Go Back"),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: data.length,
          itemBuilder: (BuildContext c, int i) {
            return AnimationConfiguration.staggeredList(
              position: i,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                horizontalOffset: 30,
                verticalOffset: 300.0,
                child: FlipAnimation(
                  duration: const Duration(milliseconds: 3000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  flipAxis: FlipAxis.y,
                  child: WeatherCard(
                    data[i].name,
                    data[i].main!.temp!.toDouble(),
                    data[i].main!.feelsLike!.toDouble(),
                    data[i].weather![0].icon,
                  ),
                  // child: Container(
                  //   margin: EdgeInsets.only(bottom: _w / 20),
                  //   height: _w / 4,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(20),
                  //     ),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.1),
                  //         blurRadius: 40,
                  //         spreadRadius: 10,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
