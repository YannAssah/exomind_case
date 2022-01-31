import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:exomind_case/data/static.dart';

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
  Timer _t = Timer.periodic(Duration(microseconds: 10), (timer) {});

  @override
  void initState() {
    super.initState();
    loadText(_t);
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
              child: Text(progressTextList[txtIndex]),
            ),
            LinearProgressIndicator(
              value: widget.percent,
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  void loadText(Timer t) {
    //Timer(duration, callback);
    // Timer(const Duration(seconds: 1), () {
    //   //_progText = progressTextList[i];
    //   t = Timer.periodic(Duration(milliseconds: 333), (_) {
    //     if (txtIndex >= progressTextList.length) {
    //       setState(() {
    //         txtIndex = 0;
    //       });
    //     } else {
    //       //Future.delayed(Duration(milliseconds: 133));
    //       setState(() {
    //         txtIndex++;
    //       });
    //     }
    //   });
    // });
    //t.cancel();
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }
}
