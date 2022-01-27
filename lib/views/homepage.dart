import 'package:exomind_case/views/forecastPage.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String homeLogo = 'assets/images/sunny.gif';
  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    // var sWidth = screenSize.width;
    // var sHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInImage(
              placeholder: AssetImage(homeLogo),
              image: AssetImage(homeLogo),
              width: 400,
              height: 400,
            ),
            //Image.asset(homeLogo),
            ElevatedButton(
              child: const Text('Aller à l\'écran suivant'),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForecastPage(),
                  ),
                )
              },
            ),
          ],
        ),
      ),
    );
  }
}
