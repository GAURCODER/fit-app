import 'dart:math';
import 'package:fit_app/constants.dart';
import 'package:fit_app/screens/home/components/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import '../../icon.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:fit_app/screens/home/components/heart_bpm.dart';
import 'package:heart_bpm/heart_bpm.dart';

bool check = false;
Valbp ob = new Valbp();

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  late AnimationController animationController;
  late Animation _animation;
  String waterConsumed = "0";
  String _status = '?', _steps = "0";
  // bool check = false;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  bool isExpanded = true;
  @override
  void initState() {
    super.initState();
    initPlatformState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      if (((event.x).abs() >= 6 && (event.y).abs() >= 6) ||
          ((event.y).abs() >= 6 && (event.z).abs() >= 6) ||
          ((event.z).abs() >= 6 && (event.x).abs() >= 6)) {
        setState(() {
          check = true;
        });
        Future.delayed(const Duration(seconds: 20), () {
          setState(() {
            check = false;
          });
        });
      }
      setState(() {});
    }));
  }

  void onStepCount(StepCount event) {
    print("step taken");
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  int intoInt(String s) {
    return int.parse(s);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.7,
                children: [
                  _card("Steps", Color(0xFFFDC830), Color(0xFFF37335),
                      'assets/images/running.png', _steps, 10000),
                  _card("Sleep", Color(0xFF4e54c8), Color(0xFF8f94fb),
                      'assets/images/sleep.png', '4', 8),
                  _cardHeartbeat("Heartbeat", Color(0xFF00b09b),
                      Color(0xFF96c93d), 'assets/images/heartbeat.png'),
                  _cardwithheart("Water", Color(0xFF00B4DB), Color(0xFF0083B0),
                      'assets/images/water-glass.png', waterConsumed, 10),
                ],
              ),
            ),
            check ? showAlert() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _card(String header, Color start, Color end, String imagePath,
      String value, int goal) {
    return Stack(children: [
      Container(
        width: 500,
        height: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
                begin: Alignment(-1.0, -4.0),
                end: Alignment(1.0, 4.0),
                colors: [
                  start,
                  end,
                ]),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
              )
            ]),
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 4,
                    vertical: kDefaultPadding / 2),
                child: Text(
                  header,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              child: Stack(alignment: Alignment.center, children: [
                SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                      showLabels: false,
                      showTicks: false,
                      minimum: 0,
                      maximum: 100,
                      radiusFactor: 0.9,
                      axisLineStyle: AxisLineStyle(
                          thickness: 0.2,
                          thicknessUnit: GaugeSizeUnit.factor,
                          cornerStyle: CornerStyle.bothCurve),
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: (intoInt(value) / goal) * 100,
                          width: 0.2,
                          sizeUnit: GaugeSizeUnit.factor,
                          cornerStyle: CornerStyle.bothCurve,
                          gradient: const SweepGradient(colors: <Color>[
                            Color(0xFFCC2B5E),
                            Color(0xFF753A88)
                          ], stops: <double>[
                            0.25,
                            0.75
                          ]),
                        )
                      ]),
                ]),
                Text(
                  value,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
              ]),
            ),
          )
        ]),
      ),
      Positioned(
        top: 0,
        left: 168,
        child: MyArc(100),
      ),
      Positioned(
        top: 8,
        left: 128,
        child: Transform(
          transform: Matrix4.identity()..scale(1 + _animation.value / 20),
          child: ImageIcon(AssetImage(imagePath)),
        ),
      )
    ]);
  }

  Widget _cardwithheart(String header, Color start, Color end, String imagePath,
      String value, int goal) {
    return Stack(children: [
      Container(
        width: 500,
        height: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
                begin: Alignment(-1.0, -4.0),
                end: Alignment(1.0, 4.0),
                colors: [
                  start,
                  end,
                ]),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
              )
            ]),
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 4,
                    vertical: kDefaultPadding / 2),
                child: Text(
                  header,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                String vit = value;
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Water"),
                    actions: <Widget>[
                      TextField(
                        onChanged: (text) {
                          vit = text;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Enter the number of glasses',
                            hintText: 'Water consumed'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          setState(() {
                            waterConsumed =
                                (intoInt(vit) + intoInt(waterConsumed))
                                    .toString();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: const Text("Yes"),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          child: const Text("No"),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                child: Stack(alignment: Alignment.center, children: [
                  SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(
                        showLabels: false,
                        showTicks: false,
                        minimum: 0,
                        maximum: 100,
                        radiusFactor: 0.9,
                        axisLineStyle: AxisLineStyle(
                            thickness: 0.2,
                            thicknessUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.bothCurve),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: (intoInt(value) / goal) * 100,
                            width: 0.2,
                            sizeUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.bothCurve,
                            gradient: const SweepGradient(colors: <Color>[
                              Color(0xFFCC2B5E),
                              Color(0xFF753A88)
                            ], stops: <double>[
                              0.25,
                              0.75
                            ]),
                          )
                        ]),
                  ]),
                  Text(
                    value,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ]),
              ),
            ),
          )
        ]),
      ),
      Positioned(
        top: 0,
        left: 168,
        child: MyArc(100),
      ),
      Positioned(
        top: 8,
        left: 128,
        child: Transform(
          transform: Matrix4.identity()..scale(1 + _animation.value / 20),
          child: ImageIcon(AssetImage(imagePath)),
        ),
      )
    ]);
  }

  Widget _cardHeartbeat(
      String header, Color start, Color end, String imagePath) {
    return Stack(children: [
      Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
                begin: Alignment(-1.0, -4.0),
                end: Alignment(1.0, 4.0),
                colors: [
                  start,
                  end,
                ]),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
              )
            ]),
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 4,
                    vertical: kDefaultPadding / 2),
                child: Text(
                  header,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (animationController.isAnimating) {
                          animationController.reset();
                        } else {
                          animationController.repeat(reverse: true);
                        }
                      },
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, _) {
                          double val = _animation.value;
                          if (animationController.status ==
                              AnimationStatus.reverse) {
                            val = 1 - val;
                          }
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFFff9966), Color(0xFFff5e62)],
                                begin: Alignment(
                                    cos(2 * pi * val), sin(2 * pi * val)),
                                end: Alignment(
                                    -cos(2 * pi * val), -sin(2 * pi * val)),
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.transparent,
                              child: Text(
                                animationController.isAnimating
                                    ? Valbp.valer.toString()
                                    : 'Last BPM',
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      )),
                ],
              ),
            ),
          )
        ]),
      ),
      Positioned(
        top: 0,
        left: 168,
        child: MyArc(100),
      ),
      Positioned(
        top: 8,
        left: 128,
        child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Transform(
                transform: Matrix4.identity()..scale(1 + _animation.value / 10),
                child: ImageIcon(AssetImage(imagePath)),
              );
            }),
      )
    ]);
  }
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

class MyArc extends StatelessWidget {
  final double diameter;

  MyArc(this.diameter);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(0.0, 0.0),
        height: size.height,
        width: size.width,
      ),
      pi / 2,
      pi / 2,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget MyAlert() {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: showAlert());
}

showAlert() {
  // Create button
  Widget okButton = FlatButton(
    child: Text("Close"),
    onPressed: () {
      check = false;
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Fall Alert Detected"),
    content: Text(
        "This is an fall detection alert.If nothing serious press close button."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  return alert;
}
