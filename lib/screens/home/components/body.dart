import 'dart:async';
import 'dart:math';

import 'package:fit_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'SensorData.dart';
import 'SensorDataChart.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<double>? _accelerometerValues;
  List<SensorData> data = [];
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  void populate(state) {
    var rng = Random();
    double time;
    if (state.length == 0) {
      time = 0.0;
    } else {
      time = state[state.length - 1].time + 1;
    }
    state.add(SensorData(time: time, value: rng.nextDouble()));
    setState(() {
      data = state;
    });
  }

  void infinite() {
    Future.delayed(Duration(milliseconds: 200), () {
      populate(data);
      infinite();
    });
  }

  @override
  void initState() {
    super.initState();
    infinite();

    // _streamSubscriptions
    //     .add(accelerometerEvents.listen((AccelerometerEvent event) {
    //   setState(() {
    //     _accelerometerValues = <double>[event.x, event.y, event.z];
    //   });
    //   print(_accelerometerValues);
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _cardWithProgressBar("Steps", "7896", "/10000", Colors.green),
        _cardWithProgressBar("Sleep", "8", "hrs", Colors.purple),
        _cardWithButton("Calories", "56", "cal", "Add food"),
        SensorDataChart(data: data)
      ],
    );
  }
}

Widget _cardWithProgressBar(
    String title, String text1, String text2, Color barColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
    child: Card(
      color: Color.fromRGBO(243, 234, 234, 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding / 2),
                  child: Row(
                    children: [
                      Text(
                        text1,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        text2,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
            Column(
              children: [
                CustomPaint(
                  child: Container(
                    width: 100,
                  ),
                  painter: ProgressBar(barColor),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget _cardWithButton(
    String title, String text1, String text2, String btnText) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
    child: Card(
      color: Color.fromRGBO(243, 234, 234, 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding / 2),
                  child: Row(
                    children: [
                      Text(
                        text1,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        text2,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
            Column(
              children: [
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add, size: 18),
                    label: Text(btnText))
              ],
            )
          ],
        ),
      ),
    ),
  );
}

class ProgressBar extends CustomPainter {
  Color lineColor;
  ProgressBar(this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double percent = 0.5;
    var paint = Paint()
      ..color = Colors.white38
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    paint.color = lineColor;
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(percent * size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
