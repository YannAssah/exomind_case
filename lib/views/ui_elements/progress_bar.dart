import 'dart:async';

import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  ProgressBar({Key? key, required this.isLoading}) : super(key: key);

  bool isLoading;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 60), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [LinearProgressIndicator()],
    );
  }
}
