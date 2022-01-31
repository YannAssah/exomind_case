import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:exomind_case/data/static.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProgressBar extends StatefulWidget {
  ProgressBar(
      {Key? key,
      required this.isLoading,
      required this.percent,
      required this.prgrssText})
      : super(key: key);

  bool isLoading;
  double percent;
  String prgrssText;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  int txtIndex = 0;
  List<String> progressTextList = [progressStr1, progressStr2, progressStr3];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Text(
                progressTextList[txtIndex],
                textAlign: TextAlign.center,
                // style: TextStyle(
                //   fontFamily: GoogleFonts.dongle(
                //       fontSize: 50, fontWeight: FontWeight.bold),
                // ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: LinearProgressIndicator(
                value: widget.percent,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
