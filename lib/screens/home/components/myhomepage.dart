// import 'dart:async';
import 'dart:math';
import 'package:fit_app/constants.dart';
import 'package:fit_app/screens/icon.dart';
import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // static const int _snakeRows = 20;
  // static const int _snakeColumns = 20;
  // static const double _snakeCellSize = 10.0;
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    // final magnetometer =
    //     _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Example'),
      ),
      body: GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: isExpanded
              ? newProgressBar(80.0, MediaQuery.of(context).size.width, 0.5)
              : card(context, 80.0),
        ),
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
      ),
    );
  }

  Container card(
    BuildContext context,
    height,
  ) {
    return Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFFDCF8EF), Color(0xFFFEE2F8)]),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "7896",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "/10000",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ));
  }

  Stack newProgressBar(height, totalWidth, double percentage) {
    percentage = max(percentage, 0.21);
    return Stack(children: [
      Container(
        height: height,
        width: totalWidth,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            gradient:
                LinearGradient(colors: [Color(0xFFFFAFBD), Color(0xFFFFC3A0)])),
      ),
      Container(
        height: height,
        width: percentage * totalWidth,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            gradient:
                LinearGradient(colors: [Color(0xFFDCF8EF), Color(0xFFFEE2F8)])),
      ),
      Container(
        height: height,
        width: height,
        margin:
            EdgeInsets.only(left: max(percentage * totalWidth - height, 0.0)),
        child: const Icon(
          MyFlutterApp.icons8_trainers_64_1__traced_,
          color: Colors.black,
          size: 28,
        ),
      )
    ]);
  }
}
