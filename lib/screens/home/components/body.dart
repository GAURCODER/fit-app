// // import 'dart:math';

// import 'package:fit_app/constants.dart';
// import 'package:fit_app/screens/home/components/myhomepage.dart';
// import 'package:flutter/material.dart';
// import 'package:pedometer/pedometer.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'dart:async';

// // String formatDate(DateTime d) {
// //   return d.toString().substring(0, 19);
// // }

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   late Stream<StepCount> _stepCountStream;
//   late Stream<PedestrianStatus> _pedestrianStatusStream;
//   String _status = '?', _steps = "0";
//   final _streamSubscriptions = <StreamSubscription<dynamic>>[];
//   bool check = false;
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//     _streamSubscriptions
//         .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
//       if (((event.x).abs() >= 6 && (event.y).abs() >= 6) ||
//           ((event.y).abs() >= 6 && (event.z).abs() >= 6) ||
//           ((event.z).abs() >= 6 && (event.x).abs() >= 6)) {
//         setState(() {
//           check = true;
//         });
//         Future.delayed(const Duration(seconds: 20), () {
//           setState(() {
//             check = false;
//           });
//         });
//       }
//       setState(() {});
//     }));
//   }
//   }

//   void onStepCount(StepCount event) {
//     print("step taken");
//     setState(() {
//       _steps = event.steps.toString();
//     });
//   }

//   void onPedestrianStatusChanged(PedestrianStatus event) {
//     print(event);
//     setState(() {
//       _status = event.status;
//     });
//   }

//   void onPedestrianStatusError(error) {
//     print('onPedestrianStatusError: $error');
//     setState(() {
//       _status = 'Pedestrian Status not available';
//     });
//     print(_status);
//   }

//   void onStepCountError(error) {
//     print('onStepCountError: $error');
//     setState(() {
//       _steps = 'Step Count not available';
//     });
//   }

//   void initPlatformState() {
//     _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
//     _pedestrianStatusStream
//         .listen(onPedestrianStatusChanged)
//         .onError(onPedestrianStatusError);

//     _stepCountStream = Pedometer.stepCountStream;
//     _stepCountStream.listen(onStepCount).onError(onStepCountError);

//     if (!mounted) return;
//   }

//   int intoInt(String s) {
//     return int.parse(s);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: <Widget>[
//         _cardWithProgressBar("Steps", _steps, "/10000",
//             const Color.fromARGB(255, 34, 230, 41), 10000),
//         _cardWithProgressBar(
//             "Sleep", "8", "hrs", const Color.fromARGB(255, 197, 39, 225), 8),
//         _cardWithButton("Calories", "56", "cal", "Add food"),
//         check? _cardWithButton("Calories", "56", "cal", "Add food"): Container(),
//       ],
//     );
//   }
// }

// Widget _cardWithProgressBar(
//     String title, String text1, String text2, Color barColor, int total) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
//     child: Card(
//       color: const Color.fromRGBO(243, 234, 234, 0.1),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: kDefaultPadding, horizontal: kDefaultPadding),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Expanded(
//                 child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: kDefaultPadding / 2),
//                   child: Row(
//                     children: [
//                       Text(
//                         text1,
//                         style: const TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       Text(
//                         text2,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             )),
//             Column(
//               children: [
//                 CustomPaint(
//                   child: Container(
//                     width: 100,
//                   ),
//                   painter: ProgressBar(barColor, int.parse(text1), total),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }

// Widget _cardWithButton(
//     String title, String text1, String text2, String btnText) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
//     child: Card(
//       color: const Color.fromRGBO(243, 234, 234, 0.1),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: kDefaultPadding, horizontal: kDefaultPadding),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Expanded(
//                 child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: kDefaultPadding / 2),
//                   child: Row(
//                     children: [
//                       Text(
//                         text1,
//                         style: const TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       Text(
//                         text2,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             )),
//             Column(
//               children: [
//                 ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.add, size: 18),
//                     label: Text(btnText))
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//   );
// }

// class ProgressBar extends CustomPainter {
//   Color lineColor;
//   int lineWidth;
//   int totalwidth;
//   ProgressBar(this.lineColor, this.lineWidth, this.totalwidth);

//   @override
//   void paint(Canvas canvas, Size size) {
//     // TODO: implement paint
//     double percent = lineWidth / totalwidth;
//     percent = percent > 1.0 ? 1.0 : percent;
//     var paint = Paint()
//       ..color = Colors.white38
//       ..strokeWidth = 10.0
//       ..strokeCap = StrokeCap.round;

//     canvas.drawLine(
//         Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
//     paint.color = lineColor;
//     canvas.drawLine(Offset(0, size.height / 2),
//         Offset(percent * size.width, size.height / 2), paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     // TODO: implement shouldRepaint
//     return false;
//   }
// }


// import 'dart:math';

import 'package:fit_app/constants.dart';
import 'package:fit_app/screens/home/components/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

// String formatDate(DateTime d) {
//   return d.toString().substring(0, 19);
// }

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = "0";
  bool check = false;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  @override
  void initState() {
    super.initState();
    initPlatformState();
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
    return ListView(
      children: <Widget>[
        _cardWithProgressBar("Steps", _steps, "/10000",
            const Color.fromARGB(255, 34, 230, 41), 10000),
        _cardWithProgressBar(
            "Sleep", "8", "hrs", const Color.fromARGB(255, 197, 39, 225), 8),
        _cardWithButton("Calories", "56", "cal", "Add food"),
        check ? _cardWithButton("Fall", "Fall", "", "") : Container(),
      ],
    );
  }
}

Widget _cardWithProgressBar(
    String title, String text1, String text2, Color barColor, int total) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
    child: Card(
      color: const Color.fromRGBO(243, 234, 234, 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding, horizontal: kDefaultPadding),
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
                  style: const TextStyle(
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
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        text2,
                        style: const TextStyle(
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
                  painter: ProgressBar(barColor, int.parse(text1), total),
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
      color: const Color.fromRGBO(243, 234, 234, 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding, horizontal: kDefaultPadding),
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
                  style: const TextStyle(
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
                        style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        text2,
                        style: const TextStyle(
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
                    icon: const Icon(Icons.add, size: 18),
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
  int lineWidth;
  int totalwidth;
  ProgressBar(this.lineColor, this.lineWidth, this.totalwidth);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double percent = lineWidth / totalwidth;
    percent = percent > 1.0 ? 1.0 : percent;
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