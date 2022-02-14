import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:exomind_case/Old/views/ui_elements/custom_progress.dart';

class TestLoad extends StatefulWidget {
  const TestLoad({Key? key}) : super(key: key);

  @override
  _TestLoadState createState() => _TestLoadState();
}

enum LoadingState { init, loading, done }

class _TestLoadState extends State<TestLoad> {
  LoadingState state = LoadingState.init;
  bool isAnimating = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDone = state == LoadingState.done;
    bool isStretched = isAnimating || state == LoadingState.init;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            onEnd: () => setState(() => isAnimating = !isAnimating),
            width: state == LoadingState.init ? (width / 2) : 70,
            height: 70,
            child: isStretched ? buildButton() : buildLoadingButton()),
      ),
    );
  }

  Widget buildButton() => OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: BorderSide(width: 2, color: Colors.blue.shade600),
        ),
        child: FittedBox(
          child: Text(
            "Recommencer",
            style: TextStyle(
              fontSize: 25,
              color: Colors.blue.shade600,
            ),
          ),
        ),
        onPressed: () async {
          setState(() => state = LoadingState.loading);
          await Future.delayed(const Duration(seconds: 3));
          setState(() => state = LoadingState.init);
        },
      );

  Widget buildLoadingButton() => Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.blue.shade600),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
}
